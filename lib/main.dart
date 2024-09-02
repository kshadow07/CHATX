import 'package:chtx/firebase_options.dart';

import 'package:chtx/screens/contactpage.dart';
import 'package:chtx/screens/login_page.dart';
import 'package:chtx/screens/reg_page.dart';
import 'package:chtx/services/Theme/dark_mode.dart';
import 'package:chtx/services/Theme/light_mode.dart';
import 'package:chtx/services/Theme/theme_provider.dart';
import 'package:chtx/services/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const Auth_Gate(),
      routes: {
        ContactPage.id: (context) => ContactPage(),
        Reg_Page.id: (context) => const Reg_Page(),
        Login_Page.id: (context) => Login_Page(),
      },
    );
  }
}
