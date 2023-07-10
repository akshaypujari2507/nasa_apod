import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/apod.dart';



class DbHelper {
  late Database _database;

  Future openDb() async {
    _database = await openDatabase(join(await getDatabasesPath(), "apod_db.db"),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
            "CREATE TABLE APOD(copyright TEXT, "
                "date TEXT, "
                "display_date TEXT, "
                "explanation TEXT, "
                "hdurl TEXT, "
                "media_type TEXT, "
                "favorite TEXT, "
                "title TEXT, "
                "url TEXT, "
                "service_version TEXT, "
                "unique (date))",
          );
        });
    return _database;
  }

  Future<int> insertAPOD(Apod apod) async {
    await openDb();
    return await _database.insert('APOD', apod.toJson(),conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Apod>> getAPODFavorite() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('APOD', where: 'favorite=?', whereArgs: ['yes']);

    return List.generate(maps.length, (i) {
      return Apod(
        copyright: maps[i]['copyright'],
        date: maps[i]['date'],
        display_date: maps[i]['display_date'],
        explanation: maps[i]['explanation'],
        hdurl: maps[i]['hdurl'],
        media_type: maps[i]['media_type'],
        service_version: maps[i]['service_version'],
        title: maps[i]['title'],
        url: maps[i]['url']);
    });
  }

  Future<Apod> getLastAPOD() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('APOD');
    print('Future<List<Apod>> getLastAPOD( count ${maps.length}');

    return  Apod(
        copyright: maps.last['copyright'],
        date: maps.last['date'],
        display_date: maps.last['display_date'],
        explanation: maps.last['explanation'],
        hdurl: maps.last['hdurl'],
        media_type: maps.last['media_type'],
        service_version: maps.last['service_version'],
        title: maps.last['title'],
        url: maps.last['url']);
  }


  Future<bool> checkFavorite(String date) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('APOD',where: "date=? and favorite=?", whereArgs: [date, 'yes']);
    return (maps.isNotEmpty);

  }

  Future<int> updateApod(Apod apod) async {
    await openDb();
    return await _database.rawUpdate('update APOD set favorite=? where date=?', [apod.favorite, apod.date]);
  }

  Future<void> deleteModel() async {
    await openDb();
    await _database.delete('APOD', where: "favorite is null or favorite=?", whereArgs: ['no']);
  }
}