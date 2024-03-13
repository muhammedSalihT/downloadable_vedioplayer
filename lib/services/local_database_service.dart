import 'dart:developer';

import 'package:downloadeble_videoplayer/screens/profile/model/profile_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static Database? _database;
  static String tableName = 'userData';
  static String userName = 'userName';
  static String userEmail = 'userEmail';
  static String userDob = 'userDob';
  static String userImage = 'userImage';
  ProfileModel? currentUserData;

  static Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  static Future<Database?> initDatabase() async {
    try {
      // Get a location using getDatabasesPath
      var dir = await getDatabasesPath();
      var path = "${dir}user.db";

      // open the database
      var database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          // When creating the db, create the table
          db.execute('''
          create table $tableName ( 
          $userName text not null,
          $userEmail text not null,
          $userDob text not null,
          $userImage text not null)
        ''');
        },
      );
      log(database.toString());
      return database;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<ProfileModel?> getUserData() async {
    log('message');
    try {
      var db = await database;
      var result = await db.query(tableName);
      if (result.isNotEmpty) {
        return ProfileModel(
          userName: result[0][userName].toString(),
          userEmail: result[0][userEmail].toString(),
          userDob: result[0][userDob].toString(),
          userImage: result[0][userImage].toString(),
        );
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  static Future<void> saveUser(ProfileModel user) async {
    try {
      var db = await database;
      await db.update(
        tableName,
        user.toMap(),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
