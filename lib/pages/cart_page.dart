import 'package:flutter/material.dart';
import 'package:kaffe/components/button.dart';
import 'package:kaffe/database/db_helper.dart';
import 'package:kaffe/models/coffee.dart';
import 'package:kaffe/models/user.dart';

class CartPage extends StatefulWidget {
  final User user;

  const CartPage({super.key, required this.user});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Coffee> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    List<Coffee> items = await dbHelper.getCartItems(widget.user.userId!);
    setState(() {
      cartItems = items;
    });
  }

  void removeFromCart(Coffee coffee) async {
    DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper.removeFromCart(widget.user.userId!, coffee.coffeeId!);
    _loadCartItems();
  }

  void placeOrder() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper.deleteCartByUserId(widget.user.userId!);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: const Text(
          "Siparişiniz başarıyla alındı!",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
    );
    _loadCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey[200],
        centerTitle: true,
        title: const Text("S e p e t i m"),
        elevation: 0,
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final Coffee coffee = cartItems[index];
                final String coffeeName = coffee.name;
                final String coffeePrice = coffee.price;

                return Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: ListTile(
                    title: Text(
                      coffeeName,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      coffeePrice,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete,
                          color: Color.fromARGB(255, 97, 97, 97)),
                      onPressed: () => removeFromCart(coffee),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: MyButton(text: "Sipariş Ver", onTap: placeOrder),
          ),
        ],
      ),
    );
  }
}
