import 'dart:io';
import "package:path/path.dart";
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  /* Singleton */
  static DatabaseHelper _databaseHelper;
  DatabaseHelper._internal();
  factory DatabaseHelper() {
    if (_databaseHelper == null) // boşsa oluştur
      _databaseHelper = DatabaseHelper._internal();
    return _databaseHelper;
  }

  /* Properties */
  Database _database;
  final String tableSmoke = "smoke";
  final String columnId = "id";
  final String columnDatetime = "datetime";
  final String columnStress = "stress";

  /* Methods */
  Future<Database> getDatabase() async {
    if (_database == null)
      _database = await DatabaseHelper()._initializeDatabase();
    return _database;
  }
  ///data/user/0/com.xaerion.sigara_metre/app_flutter/asset/smoke_counter.db

  _initializeDatabase() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    String path = join(klasor.path, "asset/smoke_counter.db");
    var smokeDB = await openDatabase(path,
        version: 1, // migration version
        onCreate: _createDB // db oluşurken çalışacak fonksiyon istedi verdik
        );
    return smokeDB;
  }

  Future _createDB(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $tableSmoke (" +
        "$columnId INTEGER PRIMARY KEY AUTOINCREMENT," +
        "$columnDatetime INTEGER NOT NULL," +
        "$columnStress INTEGER NOT NULL" +
        ")");
  }
}
