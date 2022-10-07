import 'dart:async';
import 'package:tugas_flutter_3/database/movie_class.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'myTable';
  static final columnId = '_id';
  static final columnName = 'name';

  static final DatabaseHelper instance = DatabaseHelper.init();

  static Database? _database;
  DatabaseHelper.init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('movie.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableMovie(
        ${MovieFields.id} $idType,
        ${MovieFields.idFilm} $textType,
        ${MovieFields.nama} $textType,
        ${MovieFields.img} $textType,
        ${MovieFields.tanggal} $textType,
        ${MovieFields.rating} $textType
      )''');
  }

// {
//   "_id":12,
//   "name":"saheb"
// }

  Future<MovieModel> create(MovieModel movie) async {
    final db = await instance.database;
    final id = await db.insert(tableMovie, movie.toJson());
    return movie.copy(id: id);
  }

  Future<MovieModel> read(int? idFilm) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMovie,
      columns: MovieFields.values,
      where: '${MovieFields.idFilm} = ?',
      whereArgs: [idFilm],
    );

    if (maps.isNotEmpty) {
      return MovieModel.fromJson(maps.first);
    } else {
      throw Exception('ID $idFilm not found');
    }
  }

  Future<List<MovieModel>> readAll() async {
    final db = await instance.database;
    final result = await db.query(tableMovie);
    return result.map((json) => MovieModel.fromJson(json)).toList();
  }

  update(MovieModel siswaModel) async {
    final db = await instance.database;
    try {
      db.rawUpdate('''
    UPDATE ${tableMovie} 
    SET ${MovieFields.idFilm} = ?, ${MovieFields.nama} = ?, ${MovieFields.img} = ?, ${MovieFields.tanggal} = ?, ${MovieFields.rating} = ?
    WHERE ${MovieFields.id} = ?
    ''', [
        MovieFields.idFilm,
        MovieFields.id,
        MovieFields.nama,
        MovieFields.img,
        MovieFields.tanggal,
        MovieFields.rating
      ]);
    } catch (e) {
      print('error: ' + e.toString());
    }
  }

  delete(int? idFilm) async {
    final db = await instance.database;
    try {
      await db.delete(
        tableMovie,
        where: '${MovieFields.idFilm} = ?',
        whereArgs: [idFilm],
      );
      print("finish");
    } catch (e) {
      print(e);
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
