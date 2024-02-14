import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
    CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      description TEXT,
      weight REAL,
      height REAL,
      bmi REAL,
      gender TEXT,
      birthdate TEXT,
      image TEXT, 
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
  ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'DatabaseHW.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(
      String title,
      String? description,
      double weight,
      double height,
      double bmi,
      String gender,
      String birthdate,
      String? imagePath) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'description': description,
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'gender': gender,
      'birthdate': birthdate,
      'image': imagePath,
    };
    final result = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return result;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: 'created_at DESC');
  }

  static Future<Map<String, dynamic>?> getItem(int id) async {
    final db = await SQLHelper.db();
    final result =
        await db.query('items', where: 'id = ?', whereArgs: [id], limit: 1);
    return result.isNotEmpty ? result.first : null;
  }

  static Future<int> updateItem(
      int id,
      String title,
      String? description,
      double weight,
      double height,
      double bmi,
      String gender,
      String birthdate,
      String? imagePath) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'description': description,
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'gender': gender,
      'birthdate': birthdate,
      'image': imagePath, // Update image path
      'created_at': DateTime.now().toString(),
    };
    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('items', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }
}
