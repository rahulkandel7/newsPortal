import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/bookmark.dart';

class BookmarkDatabase {
  static final BookmarkDatabase instance = BookmarkDatabase._init();

  static Database? _database;

  BookmarkDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('bookmark.db');
    return _database!;
  }

  Future<Database> _initDB(String filename) async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    final path = join(documentdirectory.path, filename);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY ';
    const stringType = 'TEXT NOT NULL';
    const imageType = 'Uint8List NOT NULL';
    const intType = 'INTEGER NOT NULL';
    await db.execute('''
      CREATE TABLE $table (
        ${BookmarkFileds.id} $idType,
        ${BookmarkFileds.title} $stringType,
        ${BookmarkFileds.description} $stringType,
        ${BookmarkFileds.categoryName} $stringType,
        ${BookmarkFileds.image} $imageType,
        ${BookmarkFileds.date} $stringType,
        ${BookmarkFileds.views} $intType
      )
    ''');
  }

  //To Insert in DB
  Future<Bookmark> create(Bookmark bookmark) async {
    final db = await instance.database;

    final id = await db.insert(table, bookmark.toJson());
    print('Created');
    return bookmark.copy(id: id);
  }

  //To Read Data from db using id
  Future<Bookmark> readBookmark(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      table,
      columns: BookmarkFileds.values,
      where: '${BookmarkFileds.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Bookmark.fromJson(maps.first);
    } else {
      throw Exception('Id is not found: $id');
    }
  }

  Future<List<Bookmark>> readAllBookmark() async {
    final db = await instance.database;

    final result = await db.query(table);

    return result.map((e) => Bookmark.fromJson(e)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      table,
      where: '${BookmarkFileds.id} = ? ',
      whereArgs: [id],
    );
  }

  Future close() async {
    final dbclose = await instance.database;
    dbclose.close();
  }
}
