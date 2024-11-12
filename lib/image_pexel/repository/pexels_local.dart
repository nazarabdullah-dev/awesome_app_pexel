import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:awesome_app/image_pexel/models/image_data.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE images (
      id INTEGER PRIMARY KEY,
      url TEXT NOT NULL,
      photographer TEXT NOT NULL,
      width INTEGER NOT NULL,
      height INTEGER NOT NULL,
      avgColor TEXT NOT NULL
      src_original TEXT NOT NULL,
      src_portrait TEXT NOT NULL,
      src_tiny TEXT NOT NULL,
      src_large TEXT NOT NULL,
      src_large2x TEXT NOT NULL,
      src_medium TEXT NOT NULL,
      src_small TEXT NOT NULL,
      src_landscape TEXT NOT NULL
      photographerUrl TEXT NOT NULL,
      photographerId INTEGER NOT NULL,
      liked INTEGER NOT NULL,
      alt TEXT NOT NULL,
      width INTEGER NOT NULL,
      height INTEGER NOT NULL
      
    )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class PexelsLocalRepository {
  Future<void> saveImageData(ImageData imageData) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('images', imageData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ImageData>> getPaginatedImages(
      {int page = 1, int perPage = 16}) async {
    final db = await DatabaseHelper.instance.database;
    final offset = (page - 1) * perPage;
    final result = await db.query('images', limit: perPage, offset: offset);

    return result.map((json) => ImageData.fromMapDatabase(json)).toList();
  }
}
