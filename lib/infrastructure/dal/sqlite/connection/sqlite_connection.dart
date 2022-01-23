import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqliteConnection {
  SqliteConnection._();

  static Completer<Database>? _dbOpenCompleter;
  static final SqliteConnection _instance = SqliteConnection._();
  static SqliteConnection get instance => _instance;

  Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  Future<Database> get db async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }

    return _dbOpenCompleter!.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'kindacode.db');

    final database = openDatabase(
      dbPath,
      version: 1,
      onCreate: (
        Database database,
        int version,
      ) async {
        await createTables(database);
      },
    );
    _dbOpenCompleter!.complete(database);
  }
}
