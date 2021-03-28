import 'package:sigara_metre/model/smoke.dart';
import 'package:sigara_metre/util/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class SmokeRepository {
  /* Singleton */
  static SmokeRepository _singleton;
  SmokeRepository._internal();
  factory SmokeRepository() {
    if (_singleton == null) {
      _singleton = SmokeRepository._internal();
    }
    return _singleton;
  }

  /* Properties */
  List<Smoke> _smokes = [];

  /* Methods */
  Future<bool> insert(Smoke smoke) async {
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.getDatabase();
    // insert
    if (await db.insert(dbHelper.tableSmoke, smoke.toMap()) > -1) {
      if (_smokes != null)
        _smokes.add(smoke); // db kayıt olursa static listeye de kayıt edilir
      return true;
    }
    return false;
  }

  Future<List<Smoke>> getAll() async {
    if (_smokes != null) {
      DatabaseHelper dbHelper = DatabaseHelper();
      Database db = await dbHelper.getDatabase();
      // select all
      List<Map<String, dynamic>> results = await db.query(dbHelper.tableSmoke);
      _smokes = [];
      for (Map<String, dynamic> i in results) {
        _smokes.add(Smoke.fromMap(i));
      }
    }
    return _smokes;
  }

  Future<bool> deleteAll() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.getDatabase();
    if (await db.delete(dbHelper.tableSmoke) > -1) {
      _smokes.clear();
      return true;
    }
    return false;
  }
}
