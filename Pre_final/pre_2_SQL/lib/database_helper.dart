import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
CREATE TABLE brands(
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
name TEXT,
price TEXT,
imageUrl TEXT
)
""");
  }

  static Future<sql.Database> get database async {
    return sql.openDatabase(
      'databaseapp.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> insertBrand(
      String name, String price, String imageUrl) async {
    final db = await database;
    final data = {'name': name, 'price': price, 'imageUrl': imageUrl};
    final id = await db.insert('brands', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getBrands() async {
    final db = await database;
    return db.query('brands', orderBy: "id");
  }

  static Future<Map<String, dynamic>?> getBrand(int id) async {
    final db = await database;
    final results =
        await db.query('brands', where: "id = ?", whereArgs: [id], limit: 1);
    return results.isNotEmpty ? results.first : null;
  }

  static Future<void> deleteBrand(int id) async {
    final db = await database;
    try {
      await db.delete("brands", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting a brand: $err');
    }
  }
}
