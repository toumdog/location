import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "myDatabase.db";
  static const _databaseVersion = 1;

  static const tableUsers = 'users';
  static const tableProperties = 'properties';

  // Users Table
  static const columnId = 'id';
  static const columnEmail = 'email';
  static const columnPassword = 'password';
  static const columnName = 'nom';
  static const columnPrenom = 'prenom';
  static const columnDateNaissance = 'dateNaissance';
  static const columnPhotoPath = 'photoPath';

  // Properties Table
  static const propertyId = 'id';
  static const userId = 'userId';
  static const adresse = 'adresse';
  static const nbrPieces = 'nbrPieces';
  static const etage = 'etage';
  static const nbrSalleDeBain = 'nbrSalleDeBain';
  static const nbrToilettes = 'nbrToilettes';
  static const balcon = 'balcon';
  static const parking = 'parking';
  static const propertyPhotoPath = 'photoPath';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableUsers (
            $columnId INTEGER PRIMARY KEY,
            $columnEmail TEXT NOT NULL,
            $columnPassword TEXT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnPrenom TEXT NOT NULL,
            $columnDateNaissance TEXT,
            $columnPhotoPath TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableProperties (
            $propertyId INTEGER PRIMARY KEY,
            $userId INTEGER,
            $adresse TEXT NOT NULL,
            $nbrPieces INTEGER NOT NULL,
            $etage INTEGER,
            $nbrSalleDeBain INTEGER,
            $nbrToilettes INTEGER,
            $balcon INTEGER,
            $parking INTEGER,
            $propertyPhotoPath TEXT,
            FOREIGN KEY ($userId) REFERENCES $tableUsers ($columnId)
          )
          ''');
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableUsers, row);
  }

  Future<int> insertProperty(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableProperties, row);
  }

  Future<List<Map<String, dynamic>>> getProperties() async {
    Database db = await instance.database;
    return await db.query(tableProperties);
  }
}
