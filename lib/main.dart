import 'package:flutter/material.dart';
import 'package:kaffe/models/shop.dart';
import 'package:kaffe/pages/cart_page.dart';
import 'package:kaffe/pages/intro_page.dart';
import 'package:kaffe/pages/login_page.dart';
import 'package:kaffe/pages/menu_page.dart';
import 'package:kaffe/pages/register_page.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: unused_local_variable
  final database = openDatabase(
    join(await getDatabasesPath(), 'kaffe_database.db'),
    onCreate: (db, version) {
      // Veritabanı tablolarını oluşturma işlemleri burada yapılır
      // Örnek: db.execute("CREATE TABLE IF NOT EXISTS ...");
    },
    version: 1,
  );
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
