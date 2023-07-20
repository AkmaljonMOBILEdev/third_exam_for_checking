import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:third_exam_n8/data/models/sql/product_model_for_sql.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();
  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("products.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''
    CREATE TABLE ${ProductModelFields.productsTableName} (
    ${ProductModelFields.id} $idType,
    ${ProductModelFields.productId} $intType,
    ${ProductModelFields.count} $intType,
    ${ProductModelFields.name} $textType,
    ${ProductModelFields.price} $intType,
    ${ProductModelFields.imageUrl} $textType,
    ${ProductModelFields.cartId} $intType
    )
    ''');

    debugPrint("-------DB----------CREATED---------");
  }

  static Future<ProductModelSql> insertProductForCart({
    required ProductModelSql productModelSql,
  }) async {
    final db = await getInstance.database;

    final result = await db.query(
      ProductModelFields.productsTableName,
      where: '${ProductModelFields.productId} = ?',
      whereArgs: [productModelSql.productId],
      limit: 1,
    );
     int id=0;
    if (result.isEmpty) {
        id = await db.insert(
        ProductModelFields.productsTableName,
        productModelSql.toJson(),
      );
        debugPrint("Added $id");
    }

    return productModelSql.copyWith(id: id);
  }


  static Future<ProductModelSql> insertProductForFav(
      {required ProductModelSql productModelSql}) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        ProductModelFields.productsTableName, productModelSql.toJson());
    return productModelSql.copyWith(id: id);
  }

  static Future<List<ProductModelSql>> getAllProducts() async {
    List<ProductModelSql> products = [];
    final db = await getInstance.database;
    products = (await db.query(ProductModelFields.productsTableName))
        .map((e) => ProductModelSql.fromJson(e))
        .toList();

    return products;
  }

  // static increaseProductCount({required int id, required int count}) async {
  //   final db = await getInstance.database;
  //   db.update(
  //     ProductModelFields.productsTableName,
  //     {ProductModelFields.count: count},
  //     where: "${ProductModelFields.id} = ?",
  //     whereArgs: [id],
  //   );
  // }

  static increaseProductCount({required ProductModelSql productModelSql}) async {
    final db = await getInstance.database;
    int newCount = productModelSql.count + 1;
    db.update(
      ProductModelFields.productsTableName,
      {ProductModelFields.count: newCount},
      where: "${ProductModelFields.cartId} = ?",
      whereArgs: [productModelSql.cartId],
    );
  }

  static decreaseProductCount({required ProductModelSql productModelSql}) async {
    final db = await getInstance.database;
    int newCount = productModelSql.count - 1;
    db.update(
      ProductModelFields.productsTableName,
      {ProductModelFields.count: newCount},
      where: "${ProductModelFields.cartId} = ?",
      whereArgs: [productModelSql.cartId],
    );
  }

  static Future<int> deleteProduct(int id) async {
    final db = await getInstance.database;
    int count = await db.delete(
      ProductModelFields.productsTableName,
      where: "${ProductModelFields.productId} = ?",
      whereArgs: [id],
    );
    return count;
  }
  static Future<int> deleteProductByCart(int id) async {
    final db = await getInstance.database;
    int sum = await db.delete(
      ProductModelFields.productsTableName,
      where: "${ProductModelFields.cartId} = ?",
      whereArgs: [id],
    );
    return sum;
  }

  static Future<int> deleteAllInCart() async {
    final db = await getInstance.database;
    int count = await db.delete(
      ProductModelFields.productsTableName,
      where: "${ProductModelFields.count} > ?",
      whereArgs: [0],
    );
    return count;
  }


  static Future<List<ProductModelSql>> getProductsForFavourites() async {
    List<ProductModelSql> products = [];
    final db = await getInstance.database;
    products = (await db.query(
      ProductModelFields.productsTableName,
      where: "${ProductModelFields.count} = ?",
      whereArgs: [0],
    ))
        .map((e) => ProductModelSql.fromJson(e))
        .toList();
    return products;
  }

  static Future<List<ProductModelSql>> getProductsForCart() async {
    List<ProductModelSql> products = [];
    final db = await getInstance.database;
    products = (await db.query(
      ProductModelFields.productsTableName,
      where: "${ProductModelFields.count} > ?",
      whereArgs: [0],
    ))
        .map((e) => ProductModelSql.fromJson(e))
        .toList();
    return products;
  }
}
