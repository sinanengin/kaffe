import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: IntroPage(),debugShowCheckedModeBanner: false,), // use MaterialApp
  );
}

class IntroPage extends StatelessWidget{
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.all(25.0),
      child: Column(
        children: [
          SizedBox(height: 25),
        // marka ismi
        Text("kaffe")

      ],),
      )
    );
    
  }
}
