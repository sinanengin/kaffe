import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaffe/components/button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 25),
              // marka ismi

              Row(
                children: [
                  const SizedBox(
                      width: 108), // İstenirse bir boşluk eklenebilir
                  Text(
                    "K A F F E",
                    style: GoogleFonts.inconsolata(
                      fontSize: 28,
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

              MyButton(
                  text: "Hadi Başlayalım",
                  onTap: () {
                    Navigator.pushNamed(context, '/menupage');
                  })
            ],
          ),
        ));
  }
}
