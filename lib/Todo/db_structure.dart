import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'list_model.dart';

class DBstructure with ChangeNotifier{
   static Database _db;

   Future<Database> get db async {
      if (_db != null) {
         return _db;
      }
      _db = await initDatabase();
      return _db;
   }

   initDatabase() async {
      io.Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path, 'listing.db');
      var db = await openDatabase(path, version: 1, onCreate: _onCreate);
      return db;
   }

   _onCreate(Database db, int version) async {
      await db
          .execute('CREATE TABLE listing (id INTEGER PRIMARY KEY, name TEXT)');
   }

   Future<Listmodel> add(Listmodel component) async {
      var dbClient = await db;
      component.id = await dbClient.insert('listing', component.toMap());
      notifyListeners();
      return component;
   }

   Future<List<Listmodel>> getListitems() async {
      var dbClient = await db;
      List<Map> maps = await dbClient.query('listing', columns: ['id', 'name']);
      List<Listmodel> component = [];
      if (maps.length > 0) {
         for (int i = 0; i < maps.length; i++) {
            component.add(Listmodel.fromMap(maps[i]));
         }
      }
      notifyListeners();
      return component;

   }


   Future<int> delete(int id) async {
      var dbClient = await db;
      var process = dbClient.delete(
         'listing',
         where: 'id = ?',
         whereArgs: [id],
      );
      notifyListeners();
      return await process;
   }


   Future close() async {
      var dbClient = await db;
      dbClient.close();
   }


}