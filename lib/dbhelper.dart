import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static final _databaseName="presons.db";
  static final _databaseVersion=1;

  static final table="my_table";
  static final columnID="id";
  static final columnName="name";
  static final columnAge="age";

  static Database _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance=DatabaseHelper._privateConstructor();  
  ///// note: we need to remember the RETURN TYPE and INPUT TYPE of functions.
  Future<Database> get database async{
    if(_database !=null)
      return _database;
    else   // IF DATABASE IS NOT AVAILABLE
    {
      _database=await _initDatabase();   //function name to call
      return _database;
    }
  }
  _initDatabase() async{     //function to create new database
    Directory documentDirectory = await getApplicationDocumentsDirectory();  // from path_provider  //getting documentDirectory
    String path=join(documentDirectory.path,_databaseName);   // join requires path package   //joining the path
    return await openDatabase(path,version: _databaseVersion,onCreate: _onCreate);   //opendatabase(path,version,onCreate)
  }
  Future _onCreate(Database db,int version)  async {
    await db.execute('''
        CREATE TABLE $table(
          $columnID INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnName TEXT NOT NULL,
          $columnAge  INTEGER NOT NULL
        )
      ''');
  }

  ////////////////// FUNCTION TO INSERT
    // INSERT function returns INTEGER (id of current inserted row)
    // INSERT function takes input( MAP<string,dynamic>)
  Future<int> insert(Map<String,dynamic> row) async{
    Database db= await instance.database;
    return await db.insert(table, row);
  }


  ////////////////// FUNCTION TO QUERYALL
    // this function returns a LIST of MAP<STRING,DYNAMIC>
    // this function not takes any input 
  Future<List<Map<String,dynamic>>> queryAll() async{
    Database db= await instance.database;
    return await db.query(table);   //return values as a LIST
  }

  Future<List<Map<String,dynamic>>> querySpecific(int age) async{
    Database db= await instance.database;
    // return await db.query(table,where: "age > ? ",whereArgs: [age]);   //return values as a LIST
    return await db.rawQuery("SELECT * FROM $table WHERE $columnAge > ?",[age]);   //return values as a LIST
  }

  Future<int> deleteData(int id) async {
    Database db=await instance.database;
    return await db.delete(table,where: "id =?",whereArgs: [id]);  //returns no. of rows deleted
  }


  Future<int> updateData(int id) async {
    Database db=await instance.database;
    return await db.update(table,{"name":"Sumit","age":25},where: "id =?",whereArgs: [id]);  //returns no. of rows deleted
  }
  
  
}