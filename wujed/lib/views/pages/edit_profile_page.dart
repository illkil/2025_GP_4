import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>(); // إذا كنت تستخدم التحقق

  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerPhoneNumber = TextEditingController();

  // أضف هذولي:
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();

  Map<String, dynamic>? userData;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void dispose() {
    controllerFirstName.dispose();
    controllerLastName.dispose();
    controllerPhoneNumber.dispose();
    controllerEmail.dispose();
    controllerUsername.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadUserData(); // ← هنا تنادي الدالة وقت ما تفتح الصفحة
  }

  Future<void> _loadUserData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        setState(() {
          userData = doc.data();
          controllerFirstName.text = userData?['first_name'] ?? '';
          controllerLastName.text = userData?['last_name'] ?? '';
          controllerPhoneNumber.text = userData?['phone_number'] ?? '';
          controllerEmail.text = userData?['email'] ?? '';
          controllerUsername.text = userData?['username'] ?? '';
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
        surfaceTintColor: Colors.transparent,
        title: Title(
          color: const Color.fromRGBO(46, 23, 21, 1),
          child: Text(
            t.edit_profile_title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              onDonePressed();
            },
            child: Text(
              t.action_done,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 95,
                  height: 95,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade500,
                  ),
                  child: const Icon(
                    IconlyBold.profile,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  t.edit_profile_change_picture,
                  style: const TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20.0),
                // ===== حقل الإيميل =====
                Row(
                  children: [
                    Text(
                      t.label_email,
                      style: const TextStyle(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                _buildTextField(
                  controllerEmail,
                  TextInputType.emailAddress,
                  [],
                  hint: t.placeholder_not_provided,
                ),

                const SizedBox(height: 20.0),

                // =====  اسم المستخدم =====
                Row(
                  children: [
                    Text(
                      t.label_username,
                      style: const TextStyle(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                _buildTextField(
                  controllerUsername,
                  TextInputType.text,
                  [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9_.]'))],
                  hint: t.placeholder_not_provided,
                ),

                Row(
                  children: [
                    Text(
                      t.label_first_name,
                      style: const TextStyle(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                _buildTextField(
                  controllerFirstName,
                  TextInputType.text,
                  [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[A-Za-z\u0600-\u06FF\s]'),
                    ),
                  ], // ← يسمح فقط بالحروف
                  hint: t.placeholder_not_provided,
                ),

                const SizedBox(height: 20.0),

                Row(
                  children: [
                    Text(
                      t.label_last_name,
                      style: const TextStyle(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                _buildTextField(
                  controllerLastName,
                  TextInputType.text,
                  [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                  hint: t.placeholder_not_provided,
                ),

                const SizedBox(height: 20.0),

                Row(
                  children: [
                    Text(
                      t.label_phone_number,
                      style: const TextStyle(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                _buildTextField(
                  controllerPhoneNumber,
                  TextInputType.phone,
                  [FilteringTextInputFormatter.digitsOnly],
                  hint: t.placeholder_not_provided,
                  isPhone: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    TextInputType type,
    List<TextInputFormatter> formatters, {
    required String hint,
    bool isPhone = false,
    String? Function(String?)? validator, //  هذا الجديد
  }) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        inputFormatters: formatters,
        validator: validator, //  وهنا استخدمناه
        autocorrect: false,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color.fromRGBO(46, 23, 21, 1),
              width: 2.0,
            ),
          ),
          suffixIcon: Icon(IconlyBold.edit, color: Colors.grey.shade400),
          prefixIcon: isPhone
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(width: 12),
                    Text(
                      '+966',
                      style: TextStyle(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 8),
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      width: 10,
                      indent: 12,
                      endIndent: 12,
                    ),
                  ],
                )
              : null,
        ),
        onEditingComplete: () => FocusScope.of(context).unfocus(),
      ),
    );
  }

  void onDonePressed() {
    final firstName = controllerFirstName.text.trim();
    final lastName = controllerLastName.text.trim();
    final phoneNumber = controllerPhoneNumber.text.trim();
    final email = controllerEmail.text.trim();
    final username = controllerUsername.text.trim();

    Navigator.pop(context, {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': '+966$phoneNumber',
      'email': email,
      'username': username,
    });
  }
}
