class Cart {
  int? cartId;
  int userId;
  int coffeeId;
  int quantity;

  Cart({
    this.cartId,
    required this.userId,
    required this.coffeeId,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'userId': userId,
      'coffeeId': coffeeId,
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      cartId: map['cartId'],
      userId: map['userId'],
      coffeeId: map['coffeeId'],
      quantity: map['quantity'],
    );
  }
}
