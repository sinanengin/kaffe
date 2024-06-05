import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaffe/components/button.dart';
import 'package:kaffe/database/db_helper.dart';
import 'package:kaffe/models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String phone = _phoneController.text;
      String password = _passwordController.text;

      DatabaseHelper dbHelper = DatabaseHelper();
      User? existingUser =
          await dbHelper.getUserByPhoneAndUsername(phone, username);

      if (existingUser != null) {
        // Kullanıcı zaten kayıtlı
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Bu telefon numarası ve kullanıcı adı ile kayıtlı bir kullanıcı zaten var.')),
        );
      } else {
        // Yeni kullanıcı kaydı
        User newUser =
            User(username: username, password: password, phone: phone);
        await dbHelper.insertUser(newUser);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Başarıyla kayıt olundu!')),
        );

        // Login sayfasına yönlendirme
        Navigator.pushNamed(context, '/loginpage');
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
                  "KAYIT OL",
                  style: GoogleFonts.inconsolata(
                    fontSize: 38,
                  ),
                ),
                Text(
                  "Kayıt olmak için aşağıdaki alanları doldurabilirsin.",
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
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Kullanıcı Adı',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kullanıcı adı gerekli';
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
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/loginpage');
                    },
                    child: const Text(
                      "Zaten bir hesabınız var mı?",
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
                        text: "Kayıt Ol",
                        onTap: _registerUser,
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
