import 'package:flutter/material.dart';
import 'package:flutter_estudos_sqlite/infrastructure/dal/sqlite/connection/sqlite_connection.dart';
import 'package:flutter_estudos_sqlite/infrastructure/dal/sqlite/entities/item_entity.dart';
import 'package:sqflite/sqflite.dart';

class ItemDao {
  final SqliteConnection connection;

  ItemDao(this.connection);

  Future<int> insert(ItemEntity item) async {
    final db = await SqliteConnection.instance.db;

    final id = await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<int> update(ItemEntity item) async {
    final db = await SqliteConnection.instance.db;
    item.createdAt = DateTime.now().toString();

    final result = await db.update(
      'items',
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
    );

    return result;
  }

  Future<void> delete(int id) async {
    final db = await SqliteConnection.instance.db;

    try {
      await db.delete(
        "items",
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SqliteConnection.instance.db;

    return db.query(
      'items',
      orderBy: "id",
    );
  }

  Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SqliteConnection.instance.db;

    return db.query(
      'items',
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );
  }
}
