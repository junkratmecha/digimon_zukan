import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/favoritedigi.dart';
import '../const/db.dart';

class FavoritesDigiDb {
  static Future<Database> openDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), favDigiFileName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $favDigiTableName(id INTEGER PRIMARY KEY)',
        );
      },
      version: 1,
    );
  }

  // ---
  // CRUD
  // Updateは不要
  // ---
  static Future<void> create(FavoriteDigi fav) async {
    var db = await openDb();
    await db.insert(
      favDigiTableName,
      fav.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<FavoriteDigi>> read() async {
    var db = await openDb();
    final List<Map<String, dynamic>> maps = await db.query(favDigiTableName);
    return List.generate(maps.length, (index) {
      return FavoriteDigi(
        digiId: maps[index]['id'],
      );
    });
  }

  //static Future<void> update(Favorite fav) async {
  //  var db = await openDb();
  //  await db.update(
  //    'favorites',
  //    fav.toMap(),
  //    where: 'id = ?',
  //    whereArgs: [fav.pokeId],
  //  );
  //  db.close();
  //}

  static Future<void> delete(int digiId) async {
    var db = await openDb();
    await db.delete(
      favTableName,
      where: 'id = ?',
      whereArgs: [digiId],
    );
  }
}