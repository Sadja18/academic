import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static const int version = 1;
  static late Database _database;
  static const dbname = 'academic.db';
  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  String _createAcademicSessionTable() {
    return 'CREATE TABLE AcademicSession('
        'sessionId TEXT NOT NULL,'
        'sessionName TEXT NOT NULL,'
        'sessionStartDate TEXT NOT NULL,'
        'sessionEndDate TEXT NOT NULL,'
        'UNIQUE(sessionId)'
        ');';
  }
  String _createSchoolTable(){
    return "CREATE  TABLE School("
    "schoolId INTEGER NOT NULL,"
    "schoolName TEXT NOT NULL,"
    "schoolCode TEXT,"
    "schoolClusterId INTEGER,"
    "schoolClusterName TEXT,"
    "schoolBlockId INTEGER,"
    "schoolBlockName TEXT,"
    "UNIQUE(schoolId)"
    ");";
  }

  String _createTeacherTable(){
    return "CREATE TABLE Teacher("
    "teacherId INTEGER NOT NULL,"
    "teacherName TEXT NOT NULL,"
    "employeeId TEXT NOT NULL,"
    "standardId TEXT,"
    "standardName TEXT,"
    "schoolId INTEGER NOT NULL,"
    "schoolName TEXT NOT NULL,"
    "teacherClusterId INTEGER NOT NULL,"
    "teacherClusterName INTEGER NOT NULL,"
    "teacherBlockId INTEGER NOT NULL,"
    "teacherBlockName INTEGER NOT NULL,"
    "UNIQUE(teacherId)"
    ");";
  }

  Future initDB() async {
    String path = join(await getDatabasesPath(), dbname);
    return await openDatabase(path,
        version: version, onOpen: (db) {}, onConfigure: (Database db) async {},
        onCreate: (Database db, int version) async {
      var batch = db.batch();
      batch.execute('CREATE TABLE user('
          'userId TEXT NOT NULL,'
          'userName TEXT NOT NULL,'
          'userPassword TEXT,'
          'dbname TEXT DEFAULT "school",'
          'academicUserGroup INTEGER NOT NULL,'
          'loginStatus INTEGER DEFAULT 0,'
          'isOnline INTEGER NOT NULL,'
          'UNIQUE(userId, userName, academicUserGroup)'
          ');');

      batch.execute(_createAcademicSessionTable());
      batch.execute(_createSchoolTable());
      batch.execute(_createTeacherTable());

      await batch.commit(noResult: true);
    }, onUpgrade: (Database db, currentVersion, nextVersion) async {});
  }

  // dynamic method for reading data
  Future<dynamic> dynamicRead(customQuery, params) async {
    try {
      final db = await initDB();
      if (params.isEmpty) {
        var resQ = await db.rawQuery(customQuery);
        var res = resQ.toList();

        return res;
      } else {
        var resQ = await db.rawQuery(customQuery, params);
        var res = resQ.toList();

        return res;
      }
    } catch (e) {
      log(e.toString());
    }
  }
  // dynamic method for reading data end

  // dynamic method for inserting data
  Future<dynamic> dynamicInsert(
      String tableName, Map<String, Object?> data) async {
    try {
      if (kDebugMode) {
        print(tableName);
      }
      final db = await initDB();
      var res = await db.insert(tableName, data,
          conflictAlgorithm: ConflictAlgorithm.replace);

      if (kDebugMode) {
        print('Inserted in $tableName $res');
      }
    } catch (e) {
      log(e.toString());
    }
  }
  // dynamic method for inserting data end

  // logout the user
  Future<dynamic> makeuserLoggedOut() async {
    final db = await initDB();

    int result = await db.update('user', {'loginStatus': 0, 'isOnline': 0},
        where: 'loginStatus=?', whereArgs: [1]);

    if (kDebugMode) {
      print(result);
    }
  }
  // logout the user end
}
