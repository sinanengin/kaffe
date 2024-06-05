import 'package:flutter/material.dart';
import 'package:kaffe/pages/intro_page.dart';
import 'package:kaffe/pages/login_page.dart';
import 'package:kaffe/pages/menu_page.dart';
import 'package:kaffe/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      routes: {
        '/intropage': (context) => const IntroPage(),
        '/menupage': (context) => const MenuPage(),
        '/loginpage': (context) => const LoginPage(),
        '/registerpage': (context) => const RegisterPage(),
      },
    );
  }
}
