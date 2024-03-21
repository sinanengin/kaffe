import 'package:flutter/material.dart';
import 'package:kaffe/pages/intro_page.dart';
import 'package:kaffe/pages/menu_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const IntroPage(),
    MenuPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // "Home" seçildiğinde MenuPage'e git
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: _selectedIndex == 0
            ? null // Eğer seçilen sayfa IntroPage ise bottomNavigationBar gösterme
            : SalomonBottomBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: [
                  SalomonBottomBarItem(
                    icon: Icon(Icons.home),
                    title: Text("Home"),
                    selectedColor: Colors.blue,
                  ),
                  SalomonBottomBarItem(
                    icon: Icon(Icons.menu),
                    title: Text("Kahveler"),
                    selectedColor: Colors.blue,
                  ),
                ],
              ),
      ),
    );
  }
}
