import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database = await openDatabase(
      path,
      version: 1, // when we increase version new column will be added
      onCreate: _createDatabase,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          // Upgrade steps from version 1 to version 2
          await db.execute('ALTER TABLE users ADD COLUMN new_column_1 TEXT');
        }

        // when we increase version need to add another if condition
        /*if (oldVersion < 3) {
          // Upgrade steps from version 2 to version 3
          await db.execute(
              'ALTER TABLE your_table ADD COLUMN new_column_2 INTEGER');
        }

        if (oldVersion < 4) {
          // Upgrade steps from version 3 to version 4
          await db
              .execute('ALTER TABLE your_table ADD COLUMN new_column_3 REAL');
        }

        if (oldVersion < 5) {
          // Upgrade steps from version 4 to version 5
          await db.execute(
              'CREATE TABLE new_table (id INTEGER PRIMARY KEY, data TEXT)');
        }*/
      },
    );
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE users (id INTEGER PRIMARY KEY,name TEXT,contact Text,description TEXT);";
    await database.execute(sql);
  }
}
