import 'package:flutter/material.dart';
import 'package:kaffe/models/coffee.dart';

class Shop extends ChangeNotifier {
  //kahve menüsü

  final List<Coffee> _coffeeMenu = [
    Coffee(
        name: "Latte",
        price: "69.90",
        imagePath: "lib/images/latte-art.png",
        rating: "4.1",
        description: "Sütlü bir kahve."),
    Coffee(
        name: "Espresso",
        price: "49.90",
        imagePath: "lib/images/expresso.png",
        rating: "4.7",
        description: "Koyu kavrulmuş kahve."),
    Coffee(
        name: "Bubble Tea",
        price: "89.90",
        imagePath: "lib/images/bubble-tea.png",
        rating: "4.8",
        description: "Baloncuklara sahip bir çay")
  ];

  //customer cart
  List<Coffee> _cart = [];

  List<Coffee> get coffeeMenu => _coffeeMenu;
  List<Coffee> get cart => _cart;

  //add
  void addToCart(Coffee coffeeItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(coffeeItem);
    }
    notifyListeners();
  }

  //remove
  void removeFromCart(Coffee coffee) {
    _cart.remove(coffee);
    notifyListeners();
  }
}
