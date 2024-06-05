import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaffe/components/button.dart';
import 'package:kaffe/database/db_helper.dart';
import 'package:kaffe/models/user.dart';
import 'menu_page.dart'; // MenuPage sınıfını import etmeyi unutmayın

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      String phone = _phoneController.text;
      String password = _passwordController.text;

      DatabaseHelper dbHelper = DatabaseHelper();
      User? user = await dbHelper.getUserByPhone(phone);

      if (user != null && user.password == password) {
        // Başarılı giriş
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuPage(user: user),
          ),
        );
      } else {
        // Hatalı giriş
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Telefon numarası veya şifre yanlış.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  "lib/images/coffee_cup-amico.png",
                  height: 330,
                  fit: BoxFit.cover,
                ),
                Text(
                  "GİRİŞ YAP",
                  style: GoogleFonts.inconsolata(
                    fontSize: 38,
                  ),
                ),
                Text(
                  "Hesabına girmek için bilgilerini doldur.",
                  style: GoogleFonts.inconsolata(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Telefon Numarası',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Telefon numarası gerekli';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Şifre',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Şifre gerekli';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {},
                    child: const Text(
                      "Şifremi Unuttum.",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: MyButton(
                        text: "Giriş Yap",
                        onTap: _loginUser,
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Hesabın yok mu?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registerpage');
                      },
                      child: const Text(
                        "Kayıt Ol",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
