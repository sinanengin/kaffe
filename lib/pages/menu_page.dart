import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaffe/components/button.dart';
import 'package:kaffe/components/coffee_tile.dart';
import 'package:kaffe/database/db_helper.dart';
import 'package:kaffe/models/coffee.dart';
import 'package:kaffe/models/user.dart';
import 'package:kaffe/pages/coffee_details_page.dart';
import 'package:kaffe/pages/cart_page.dart';

class MenuPage extends StatefulWidget {
  final User? user;

  const MenuPage({super.key, this.user});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Coffee> coffeeMenu = [];
  Coffee? randomCoffee;

  @override
  void initState() {
    super.initState();
    _loadCoffeeMenu();
  }

  void _loadCoffeeMenu() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    List<Coffee> coffees = await dbHelper.getAllCoffees();
    setState(() {
      coffeeMenu = coffees;
      randomCoffee = (coffees..shuffle()).first;
    });
  }

  // coffee details navigator
  void navigateToCoffeeDetails(int index) {
    if (widget.user == null) {
      // Kullanıcı giriş yapmamış, uyarı mesajı göster
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Uyarı"),
          content:
              const Text("Kahve alabilmek için giriş yapmanız gerekmektedir."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tamam"),
            ),
          ],
        ),
      );
    } else {
      // Kullanıcı giriş yapmış, CoffeeDetailsPage'e yönlendir
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoffeeDeatilsPage(
            coffee: coffeeMenu[index],
            user: widget.user,
          ),
        ),
      );
    }
  }

  void navigateToCoffeeDetailsByCoffee(Coffee coffee) {
    if (widget.user == null) {
      // Kullanıcı giriş yapmamış, uyarı mesajı göster
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Uyarı"),
          content:
              const Text("Kahve alabilmek için giriş yapmanız gerekmektedir."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tamam"),
            ),
          ],
        ),
      );
    } else {
      // Kullanıcı giriş yapmış, CoffeeDetailsPage'e yönlendir
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoffeeDeatilsPage(
            coffee: coffee,
            user: widget.user,
          ),
        ),
      );
    }
  }

  void navigateToCartPage() {
    if (widget.user == null) {
      // Kullanıcı giriş yapmamış, uyarı mesajı göster
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Uyarı"),
          content:
              const Text("Sepete erişmek için giriş yapmanız gerekmektedir."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tamam"),
            ),
          ],
        ),
      );
    } else {
      // Kullanıcı giriş yapmış, CartPage'e yönlendir
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartPage(user: widget.user!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        leading: const Icon(
          Icons.menu,
        ),
        title: const Text(
          "K A F F E",
        ),
        actions: [
          IconButton(
            onPressed: navigateToCartPage,
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (widget.user == null)
            Container(
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        "Fırsatları Kaçırma!",
                        style: GoogleFonts.inconsolata(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyButton(
                        text: "Üye Ol",
                        onTap: () {
                          Navigator.pushNamed(context, '/registerpage');
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                  Image.asset(
                    'lib/images/coffee-cup.png',
                    height: 120,
                  ),
                ],
              ),
            )
          else
            Container(
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        "Merhaba, ${widget.user!.username}!",
                        style: GoogleFonts.inconsolata(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                  Image.asset(
                    'lib/images/coffee-cup.png',
                    height: 120,
                  ),
                ],
              ),
            ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Buradan arama yapabilirsin..",
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Kahvelerimiz",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: coffeeMenu.length,
              itemBuilder: (context, index) => CoffeeTile(
                coffee: coffeeMenu[index],
                onTap: () => navigateToCoffeeDetails(index),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          // popüler kahveler
          if (randomCoffee != null)
            GestureDetector(
              onTap: () => navigateToCoffeeDetailsByCoffee(randomCoffee!),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          randomCoffee!.imagePath,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(randomCoffee!.name),
                            Text(
                              "${randomCoffee!.price} TL",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.favorite,
                      color: Colors.grey,
                      size: 28,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
