import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';

// Firebase Imports
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// تعريف المتغيرات العامة المقدمة من بيئة العمل
// يجب أن تكون هذه المتغيرات معرّفة في البيئة الخارجية ليتمكن التطبيق من الاتصال بـ Firebase
const String __app_id = 'flutter-reports-app';
const String __firebase_config = '{}'; 
const String __initial_auth_token = ''; 

// ------------------------------------------------------------------
// 1. النماذج (Models)
// ------------------------------------------------------------------

enum ReportStatus { pending, approved, rejected }

// دالة مساعدة لتحويل النص إلى Enum
ReportStatus _statusFromString(String status) {
  try {
    return ReportStatus.values.firstWhere(
      (e) => e.toString().split('.').last == status,
      orElse: () => ReportStatus.pending,
    );
  } catch (e) {
    return ReportStatus.pending;
  }
}

// نموذج التقرير (يتوافق مع مستند Firestore)
class ReportModel {
  final String id; // Document ID
  final String title;
  final String type; // 'lost' or 'found'
  final ReportStatus status;

  ReportModel({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
  });

  factory ReportModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ReportModel(
      id: doc.id,
      title: data['title'] ?? 'تقرير بدون عنوان',
      type: data['type'] ?? 'lost',
      status: _statusFromString(data['status'] ?? 'pending'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'status': status.toString().split('.').last,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}

// نموذج الإشعار
class NotificationItem {
  final String id; // Document ID
  final String title;
  final String body;
  final String time; // يتم تخزين Timestamp من Firestore

  NotificationItem({required this.id, required this.title, required this.body, required this.time});

  factory NotificationItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final timestamp = data['createdAt'] as Timestamp?;
    String timeStr = 'غير محدد';
    if (timestamp != null) {
      final dateTime = timestamp.toDate();
      timeStr = DateFormat('yyyy/MM/dd HH:mm').format(dateTime);
    }

    return NotificationItem(
      id: doc.id,
      title: data['title'] ?? 'إشعار جديد',
      body: data['body'] ?? 'لا يوجد تفاصيل',
      time: timeStr,
    );
  }
}

// ------------------------------------------------------------------
// 2. مدير البيانات والخدمات (Firebase Manager)
// ------------------------------------------------------------------

class FirebaseManager extends ChangeNotifier {
  FirebaseApp? app;
  FirebaseFirestore? db;
  FirebaseAuth? auth;
  String? userId;
  bool isInitialized = false;

  // قوائم يتم تحديثها في الوقت الفعلي من Firestore
  List<ReportModel> allReports = [];
  List<NotificationItem> notifications = [];

  // مسارات Firestore
  String get _appId => __app_id;
  String get _reportsCollectionPath => '/artifacts/$_appId/users/$userId/reports';
  String get _notificationsCollectionPath => '/artifacts/$_appId/users/$userId/notifications';

  // الـ Streams للتخلص منها عند الحاجة
  StreamSubscription? _reportsSubscription;
  StreamSubscription? _notificationsSubscription;

  Future<void> initializeFirebase() async {
    if (isInitialized) return;

    try {
      final firebaseConfig = jsonDecode(__firebase_config) as Map<String, dynamic>;
      app = await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: firebaseConfig['apiKey'] ?? '',
          appId: firebaseConfig['appId'] ?? '',
          messagingSenderId: firebaseConfig['messagingSenderId'] ?? '',
          projectId: firebaseConfig['projectId'] ?? '',
          storageBucket: firebaseConfig['storageBucket'] ?? '',
        ),
      );
      db = FirebaseFirestore.instanceFor(app: app!);
      auth = FirebaseAuth.instanceFor(app: app!);

      await _signIn();
      userId = auth!.currentUser?.uid;

      _setupListeners();
      await _initializeReports();
      isInitialized = true;
      notifyListeners();

    } catch (e) {
      debugPrint('Error initializing Firebase or signing in: $e');
      // في حالة الفشل، قد نختار استخدام مُعرّف عشوائي كبديل
      userId = auth?.currentUser?.uid ?? 'anonymous_user';
      isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> _signIn() async {
    try {
      if (__initial_auth_token.isNotEmpty) {
        await auth!.signInWithCustomToken(__initial_auth_token);
      } else {
        await auth!.signInAnonymously();
      }
    } on Exception catch (e) {
      debugPrint('Auth Error: $e');
      await auth!.signInAnonymously();
    }
  }

  // إعداد مستمعي Firestore للحصول على تحديثات في الوقت الفعلي
  void _setupListeners() {
    if (db == null || userId == null) return;

    // 1. الاستماع للتقارير (Reports)
    final reportsQuery = db!.collection(_reportsCollectionPath).orderBy('createdAt', descending: true);
    _reportsSubscription = reportsQuery.snapshots().listen((snapshot) {
      allReports = snapshot.docs.map((doc) => ReportModel.fromFirestore(doc)).toList();
      _handleReportStatusChanges(snapshot.docChanges); // معالجة تغيير الحالة هنا
      notifyListeners();
    }, onError: (error) {
      debugPrint('Error listening to reports: $error');
    });

    // 2. الاستماع للإشعارات (Notifications)
    final notificationsQuery = db!.collection(_notificationsCollectionPath).orderBy('createdAt', descending: true);
    _notificationsSubscription = notificationsQuery.snapshots().listen((snapshot) {
      notifications = snapshot.docs.map((doc) => NotificationItem.fromFirestore(doc)).toList();
      notifyListeners();
    }, onError: (error) {
      debugPrint('Error listening to notifications: $error');
    });
  } 

  // محاكاة النظام الخلفي: إضافة إشعار عند تغيير حالة تقرير إلى 'rejected'
  void _handleReportStatusChanges(List<DocumentChange> changes) {
    for (var change in changes) {
      if (change.type == DocumentChangeType.modified) {
        final newReport = ReportModel.fromFirestore(change.doc);
        final oldReportStatus = _statusFromString(change.oldIndex >= 0 
            ? (change.doc.data() as Map<String, dynamic>?)?['status'] ?? 'pending' 
            : 'pending');

        // إذا كانت الحالة الجديدة 'مرفوض' والحالة القديمة لم تكن 'مرفوض'
        if (newReport.status == ReportStatus.rejected && oldReportStatus != ReportStatus.rejected) {
          // هذا هو إجراء النظام الخلفي (Cloud Function simulation)
          _createRejectionNotification(newReport.title);
        }
      }
    }
  }

  // دالة تُنشئ إشعاراً وتضيفه إلى Firestore
  Future<void> _createRejectionNotification(String reportTitle) async {
    if (db == null || userId == null) return;

    final notificationData = {
      'title': '⚠️ تم رفض التقرير',
      'body': 'نأسف لإبلاغك بأنه تم رفض التقرير الخاص بك: "$reportTitle". يرجى المراجعة.',
      'createdAt': FieldValue.serverTimestamp(),
    };

    await db!.collection(_notificationsCollectionPath).add(notificationData);
    debugPrint('Notification added for report: $reportTitle');
  }

  // تحديث حالة التقرير في Firestore (إجراء المشرف/النظام)
  Future<void> updateReportStatus(String reportId, ReportStatus newStatus) async {
    if (db == null || userId == null) return;

    final statusString = newStatus.toString().split('.').last;
    await db!.collection(_reportsCollectionPath).doc(reportId).update({
      'status': statusString,
    });
  }
  
  // دالة لإضافة بيانات أولية للتشغيل الأول
  Future<void> _initializeReports() async {
    if (db == null || userId == null) return;

    final reportsCollection = db!.collection(_reportsCollectionPath);
    final snapshot = await reportsCollection.limit(1).get();

    if (snapshot.docs.isEmpty) {
      debugPrint('Initializing default reports...');
      final reports = [
        ReportModel(id: '', title: 'هاتف آيفون (مقبول)', type: 'lost', status: ReportStatus.approved),
        ReportModel(id: '', title: 'حقيبة ظهر سوداء (انتظار)', type: 'lost', status: ReportStatus.pending),
        ReportModel(id: '', title: 'ساعة يد رقمية (مرفوض)', type: 'lost', status: ReportStatus.rejected),
        ReportModel(id: '', title: 'مفتاح سيارة (مقبول)', type: 'found', status: ReportStatus.approved),
        ReportModel(id: '', title: 'محفظة بنية (مرفوض)', type: 'found', status: ReportStatus.rejected),
      ];

      for (var report in reports) {
        await reportsCollection.add(report.toMap());
      }
    }
  }

  @override
  void dispose() {
    _reportsSubscription?.cancel();
    _notificationsSubscription?.cancel();
    super.dispose();
  }
}

// ------------------------------------------------------------------
// 3. صفحة الإشعارات (NotificationsPage)
// ------------------------------------------------------------------

class NotificationsPage extends StatelessWidget {
  final FirebaseManager manager;

  const NotificationsPage({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder يستمع للتغييرات في مدير البيانات
    return ListenableBuilder(
      listenable: manager,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            title: const Text(
              'الإشعارات',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: !manager.isInitialized 
              ? const Center(child: CircularProgressIndicator())
              : manager.notifications.isEmpty
                  ? const Center(
                      child: Text('لا توجد إشعارات حاليًا'),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      itemCount: manager.notifications.length,
                      separatorBuilder: (context, index) => const Divider(indent: 20, endIndent: 20),
                      itemBuilder: (context, index) {
                        final notification = manager.notifications[index];
                        return ListTile(
                          leading: const Icon(Icons.notifications_active, color: Colors.deepPurple),
                          title: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(notification.body),
                          trailing: Text(notification.time, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                        );
                      },
                    ),
        );
      },
    );
  }
}

// ------------------------------------------------------------------
// 4. صفحة عرض التقارير (HistoryPage)
// ------------------------------------------------------------------

class HistoryPage extends StatefulWidget {
  final FirebaseManager manager;

  const HistoryPage({super.key, required this.manager});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int selectedIndex = 0; // 0 for Lost, 1 for Found

  // دالة مساعدة للحصول على اللون بناءً على الحالة
  Color _getStatusColor(ReportStatus status) {
    switch (status) {
      case ReportStatus.approved:
        return Colors.green.shade600;
      case ReportStatus.rejected:
        return Colors.red.shade600;
      case ReportStatus.pending:
        return Colors.orange.shade600;
    }
  }

  // دالة مساعدة للحصول على النص بناءً على الحالة
  String _getStatusText(ReportStatus status) {
    switch (status) {
      case ReportStatus.approved:
        return 'مقبول';
      case ReportStatus.rejected:
        return 'مرفوض';
      case ReportStatus.pending:
        return 'في الانتظار';
    }
  }

  // بناء قائمة التقارير الفعلي
  Widget _buildReportList(List<ReportModel> allReports) {
    final filteredReports = allReports.where((r) => r.type == (selectedIndex == 0 ? 'lost' : 'found')).toList();

    if (filteredReports.isEmpty) {
      return const Center(child: Text('لا توجد تقارير في هذا القسم.'));
    }

    return ListView.builder(
      itemCount: filteredReports.length,
      itemBuilder: (context, index) {
        final report = filteredReports[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 1,
          child: ListTile(
            title: Text(report.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              'الحالة: ${_getStatusText(report.status)}',
              style: TextStyle(color: _getStatusColor(report.status), fontWeight: FontWeight.w600),
            ),
            // قائمة خيارات لتغيير الحالة (لأغراض المحاكاة)
            trailing: PopupMenuButton<ReportStatus>(
              itemBuilder: (context) => [
                const PopupMenuItem(value: ReportStatus.approved, child: Text('تغيير إلى: مقبول')),
                const PopupMenuItem(value: ReportStatus.rejected, child: Text('تغيير إلى: مرفوض')),
                const PopupMenuItem(value: ReportStatus.pending, child: Text('تغيير إلى: في الانتظار')),
              ],
              onSelected: (newStatus) async {
                if (report.status == newStatus) return;
                
                // تحديث الحالة في Firestore
                await widget.manager.updateReportStatus(report.id, newStatus);
                
                // إظهار تنبيه لحظي للمستخدم بأن التغيير تم إرساله
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('تم إرسال تحديث الحالة إلى النظام (Firestore)'),
                    backgroundColor: Colors.blue.shade700,
                  ),
                );
              },
              child: const Icon(Icons.more_vert),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // محاكاة الوصول إلى التوطين
    const String historyTitle = 'سجل التقارير';
    const String tabLost = 'مفقودات';
    const String tabFound = 'مكتشفات';

    return ListenableBuilder(
      listenable: widget.manager,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
            surfaceTintColor: Colors.transparent,
            title: Text(
              historyTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromRGBO(46, 23, 21, 1)),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedIndex = 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: selectedIndex == 0
                                  ? const Color.fromRGBO(46, 23, 21, 1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              tabLost,
                              style: TextStyle(
                                color: selectedIndex == 0
                                    ? Colors.white
                                    : const Color.fromRGBO(46, 23, 21, 1),
                                fontWeight: selectedIndex == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedIndex = 1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: selectedIndex == 1
                                  ? const Color.fromRGBO(46, 23, 21, 1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              tabFound,
                              style: TextStyle(
                                color: selectedIndex == 1
                                    ? Colors.white
                                    : const Color.fromRGBO(46, 23, 21, 1),
                                fontWeight: selectedIndex == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    // عرض شاشة التحميل إذا لم يتم التهيئة بعد
                    child: !widget.manager.isInitialized
                        ? const Center(child: CircularProgressIndicator())
                        : _buildReportList(widget.manager.allReports),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ------------------------------------------------------------------
// 5. التطبيق الرئيسي (Main App) لتشغيل الصفحتين
// ------------------------------------------------------------------

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // مثيل وحيد لمدير البيانات
  final FirebaseManager _manager = FirebaseManager();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // بدء تهيئة Firebase والاستماع للبيانات
    _manager.initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'محاكاة الإشعارات',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(secondary: const Color.fromRGBO(46, 23, 21, 1)),
        fontFamily: 'Tajawal',
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            // صفحة التقارير، نمرر لها مدير البيانات
            HistoryPage(manager: _manager),
            // صفحة الإشعارات، نمرر لها مدير البيانات
            NotificationsPage(manager: _manager),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: const Color.fromRGBO(46, 23, 21, 1),
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'التقارير',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'الإشعارات',
            ),
          ],
        ),
      ),
    );
  }
}