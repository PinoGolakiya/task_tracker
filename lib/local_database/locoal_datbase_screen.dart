import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String tableName = 'boards';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'boards.db');
    var boardsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return boardsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, boardName TEXT, description TEXT)',
    );
  }

  Future<int> insertBoard(Map<String, dynamic> board) async {
    Database db = await this.database;
    var result = await db.insert(tableName, board);
    return result;
  }

  Future<List<Map<String, dynamic>>> getBoardList() async {
    Database db = await this.database;
    var result = await db.query(tableName);
    return result;
  }
  Stream<List<Map<String, dynamic>>> boardListStream() async* {
    while (true) {
      yield await getBoardList();
      await Future.delayed(Duration(seconds: 1)); // Adjust delay as needed
    }}
}
