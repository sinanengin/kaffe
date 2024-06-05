class User {
  int? userId;
  String username;
  String password;
  String phone;

  User({
    this.userId,
    required this.username,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'password': password,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      username: map['username'],
      password: map['password'],
      phone: map['phone'],
    );
  }
}
