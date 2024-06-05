class Coffee {
  int? coffeeId;
  String name;
  String price;
  String imagePath;
  String rating;
  String description;

  Coffee({
    this.coffeeId,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.rating,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'coffeeId': coffeeId,
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'rating': rating,
      'description': description,
    };
  }

  factory Coffee.fromMap(Map<String, dynamic> map) {
    return Coffee(
      coffeeId: map['coffeeId'],
      name: map['name'],
      price: map['price'],
      imagePath: map['imagePath'],
      rating: map['rating'],
      description: map['description'],
    );
  }
}
