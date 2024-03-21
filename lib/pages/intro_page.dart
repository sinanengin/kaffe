import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaffe/pages/menu_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: IntroPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/menupage': (context) => MenuPage(),
      },
    ),
  );
}

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 25),
              // marka ismi

              Row(
                children: [
                  const SizedBox(
                    width: 30,
                    height: 30,
                    child: Image(
                      image: AssetImage('lib/images/coffee-cup.png'),
                    ),
                  ),
                  const SizedBox(width: 5), // İstenirse bir boşluk eklenebilir
                  Text(
                    "kaffe",
                    style: GoogleFonts.inconsolata(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 25,
              ),

              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset('lib/images/coffee-beans.png'),
              ),

              const SizedBox(
                height: 25,
              ),

              Text(
                "Kaffe keyfini evinde yaşa!",
                style: GoogleFonts.inconsolata(
                  fontSize: 44,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Text(
                "Eşsiz lezzetin keyfine varmak için Kaffe lezzeti şimdi bir tıkla kapınızda!",
                style: GoogleFonts.inconsolata(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 120,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuPage()),
                  );
                },
                child: Text("Hadi Başlayalım!"),
              ),
            ],
          ),
        ));
  }
}
