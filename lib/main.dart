import 'package:flutter/material.dart';
import 'package:kaffe/models/shop.dart';
import 'package:kaffe/pages/cart_page.dart';
import 'package:kaffe/pages/intro_page.dart';
import 'package:kaffe/pages/login_page.dart';
import 'package:kaffe/pages/menu_page.dart';
import 'package:kaffe/pages/register_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Shop(),
    child: const MyApp(),
  ));
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
        '/cartpage': (context) => const CartPage(),
        '/loginpage': (context) => const LoginPage(),
        '/registerpage': (context) => const RegisterPage(),
      },
    );
  }
}
