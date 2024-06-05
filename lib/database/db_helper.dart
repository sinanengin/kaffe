import 'dart:io';
import 'package:kaffe/models/cart.dart';
import 'package:kaffe/models/coffee.dart';
import 'package:kaffe/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "kaffe_db.db");
    return await openDatabase(path,
        version: 4, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        phone TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE coffees (
        coffeeId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price TEXT NOT NULL,
        imagePath TEXT NOT NULL,
        rating TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE carts (
        cartId INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        coffeeId INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        FOREIGN KEY (userId) REFERENCES users (userId),
        FOREIGN KEY (coffeeId) REFERENCES coffees (coffeeId)
      )
    ''');

    await _insertInitialCoffees(db);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {}
  }

  Future<void> _insertInitialCoffees(Database db) async {
    await db.insert('coffees', {
      'name': 'Espresso',
      'price': '19.99',
      'imagePath': 'lib/images/expresso.png',
      'rating': '4.5',
      'description': 'A rich, full-flavored coffee with a velvety crema.'
    });

    await db.insert('coffees', {
      'name': 'Latte',
      'price': '24.99',
      'imagePath': 'lib/images/latte.jpg',
      'rating': '4.8',
      'description': 'A creamy blend of espresso and steamed milk.'
    });

    await db.insert('coffees', {
      'name': 'Bubble Tea',
      'price': '22.99',
      'imagePath': 'lib/images/bubble-tea.png',
      'rating': '4.7',
      'description': 'A perfect balance of espresso, steamed milk, and foam.'
    });
  }

  // CRUD İşlemleri
  Future<User?> getUserByUsername(String username) async {
    final db = await database;
    var res =
        await db.query('users', where: 'username = ?', whereArgs: [username]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  Future<User?> getUserByPhone(String phone) async {
    final db = await database;
    var res = await db.query('users', where: 'phone = ?', whereArgs: [phone]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  Future<User?> getUserByPhoneAndUsername(String phone, String username) async {
    final db = await database;
    var res = await db.query('users',
        where: 'phone = ? AND username = ?', whereArgs: [phone, username]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap());
  }

  Future<void> insertCoffee(Coffee coffee) async {
    final db = await database;
    await db.insert('coffees', coffee.toMap());
  }

  Future<List<Coffee>> getAllCoffees() async {
    final db = await database;
    var res = await db.query('coffees');
    List<Coffee> list =
        res.isNotEmpty ? res.map((c) => Coffee.fromMap(c)).toList() : [];
    return list;
  }

  Future<Coffee?> getCoffeeById(int coffeeId) async {
    final db = await database;
    var res =
        await db.query('coffees', where: 'coffeeId = ?', whereArgs: [coffeeId]);
    return res.isNotEmpty ? Coffee.fromMap(res.first) : null;
  }

  Future<void> insertCart(Cart cart) async {
    final db = await database;
    await db.insert('carts', cart.toMap());
  }

  Future<void> deleteCartByUserId(int userId) async {
    final db = await database;
    await db.delete('carts', where: 'userId = ?', whereArgs: [userId]);
  }

  Future<void> removeFromCart(int userId, int coffeeId) async {
    final db = await database;
    await db.delete('carts',
        where: 'userId = ? AND coffeeId = ?', whereArgs: [userId, coffeeId]);
  }

  Future<List<Coffee>> getCartItems(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> cartItemsMaps = await db.rawQuery('''
      SELECT c.* FROM carts ct
      INNER JOIN coffees c ON ct.coffeeId = c.coffeeId
      WHERE ct.userId = ?
    ''', [userId]);

    List<Coffee> cartItems = cartItemsMaps.isNotEmpty
        ? cartItemsMaps.map((map) => Coffee.fromMap(map)).toList()
        : [];
    return cartItems;
  }
}
