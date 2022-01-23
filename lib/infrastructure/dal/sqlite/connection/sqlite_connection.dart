import 'package:sqflite/sqflite.dart' as sqflite;

class SqliteConnection {
  SqliteConnection._();

  static final SqliteConnection _instance = SqliteConnection._();
  static SqliteConnection get instance => _instance;

  Future<void> createTables(sqflite.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  Future<sqflite.Database> db() async {
    return sqflite.openDatabase(
      'kindacode.db',
      version: 1,
      onCreate: (sqflite.Database database, int version) async {
        await createTables(database);
      },
    );
  }
}
