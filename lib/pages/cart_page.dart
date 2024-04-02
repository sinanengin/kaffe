import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:kaffe/components/button.dart";
import "package:kaffe/models/coffee.dart";
import "package:kaffe/models/shop.dart";
import "package:provider/provider.dart";

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeFromCart(Coffee coffee, BuildContext context) {
    final shop = context.read<Shop>();

    shop.removeFromCart(coffee);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.grey[200],
          centerTitle: true,
          title: const Text("S e p e t i m"),
          elevation: 0,
          backgroundColor: Colors.brown,
        ),
        body:
            //customer cart
            Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: value.cart.length,
                itemBuilder: (context, index) {
                  final Coffee coffee = value.cart[index];
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
                        onPressed: () => removeFromCart(coffee, context),
                      ),
                    ),
                  );
                },
              ),
            ),

            //pay button
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: MyButton(text: "Sipariş Ver", onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
