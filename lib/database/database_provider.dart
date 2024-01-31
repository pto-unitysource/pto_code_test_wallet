import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider{
  static final DatabaseProvider databaseProvider = DatabaseProvider();

  Database? database;

  Future<Database> get db async {
    if (database != null) {
      return database!;
    } else {
      database = await createDatabase();
      return database!;
    }
  }

  Future<Database> createDatabase() async{
    Directory doc = await getApplicationDocumentsDirectory();
    String path = join(doc.path, "pto_wallet.db");
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async{
        await db.execute("CREATE TABLE users ("
            "uid TEXT PRIMARY KEY, "
            "name TEXT, "
            "email TEXT, "
            "imgUrl TEXT, "
            "amount REAL "
            ")");
        await db.execute("CREATE TABLE transactions ("
            "id TEXT PRIMARY KEY, "
            "amount REAL, "
            "from TEXT, "
            "to TEXT, "
            "sendDate TEXT, "
            "note TEXT "
            ")");
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {
        if (newVersion > oldVersion) {}
      },
    );
    return database;
  }
}