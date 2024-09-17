import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/features/login/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/onboarding/screens/welcome_page.dart';
import 'firebase_options.dart';
import 'themes/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme, // Apply the light theme

      locale: Locale('ar', ''), // Set the locale to Arabic (or any RTL language)

      home:  WelcomePage(),
       localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''), // Arabic, RTL language
        // Add other locales if needed
      ],
      debugShowCheckedModeBanner: true,
    );
  }
}
