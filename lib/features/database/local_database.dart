import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class LocalDataBase {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        userName TEXT,
        userDescription TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a User
// title, description: name and description of your activity
// created_at: the time that the User was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'userData.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new User (journal)
  static Future<int> createUser(String title, String? descrption) async {
    final db = await LocalDataBase.db();

    final data = {'userName': title, 'userDescription': descrption};
    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print('checking db path ${db}');
    return id;
  }

  // Read all users (journals)
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await LocalDataBase.db();
    var data =await  db.query('users');
    for(var user in data){
      print('checking the user data ${user}');
    }
    return db.query('users', orderBy: "id");
  }

  // Read a single User by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getUser(int id) async {
    final db = await LocalDataBase.db();
    return db.query('users', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an User by id
  static Future<int> updateUser(
      int id, String userName, String? userDescription) async {
    final db = await LocalDataBase.db();

    final data = {
      'userName': userName,
      'userDescription': userDescription,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('users', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteUser(int id) async {
    final db = await LocalDataBase.db();
    try {
      await db.delete("users", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an User: $err");
    }
  }
}