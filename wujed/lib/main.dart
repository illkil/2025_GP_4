import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wujed/auth/main_page.dart';
import 'package:wujed/firebase_options.dart';
import 'package:wujed/views/pages/loading_page.dart';
import 'l10n/generated/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode || kProfileMode) {
    await FirebaseAppCheck.instance.activate(
      providerAndroid: AndroidDebugProvider(),
      providerApple: AppleDebugProvider(),
    );
  } else {
    await FirebaseAppCheck.instance.activate(
      providerAndroid: AndroidPlayIntegrityProvider(),
      providerApple: AppleAppAttestProvider(),
    );
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  bool? isFirstTime;

  void setLocale(Locale locale) => setState(() => _locale = locale);

  Future<void> _loadFirstTimeFlag() async {
    final prefs = await SharedPreferences.getInstance();

    final bool firstTime = prefs.getBool('isFirstTime') ?? true;
    final String? lang = prefs.getString('preferredLanguage');

    setState(() {
      isFirstTime = firstTime;
      _locale = lang != null ? Locale(lang) : const Locale('en'); 
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFirstTimeFlag();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appTitle,
      home: isFirstTime == null
          ? Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(255, 175, 0, 1),
                ),
              ),
            )
          : (isFirstTime! ? const LoadingPage() : const MainPage()),
    );
  }
}
