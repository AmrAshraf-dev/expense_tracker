import 'package:expense_tracker/model/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDatabase {
  static final ExpenseDatabase instance = ExpenseDatabase._init();

  static Database? _database;

  ExpenseDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE expenses (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      category TEXT,
      amount REAL,
      date TEXT,
      imagePath TEXT
      filePath TEXT
    )
    ''');
  }

  Future<List<ExpenseModel>> getExpenses(
      {required int offset, required int limit}) async {
    final db = await instance.database;

    final result = await db.query(
      'expenses',
      offset: offset,
      limit: limit,
      orderBy: 'id DESC',
    );

    return result.map((map) => ExpenseModel.fromMap(map)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
