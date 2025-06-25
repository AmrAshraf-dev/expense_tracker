import 'package:expense_tracker/model/expense_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    return _database ??= await _initDb();
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expenses.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE expenses (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT,
            amount REAL,
            date TEXT,
            imagePath TEXT,
            filePath TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertExpense(ExpenseModel expense) async {
    final db = await database;
    return await db.insert('expenses', expense.toMap());
  }

//Fetching offline data
  Future<List<ExpenseModel>> getExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');

    return maps
        .map((e) => ExpenseModel(
              id: e['id'],
              category: e['category'],
              amount: e['amount'],
              date: e['date'],
              imagePath: e['imagePath'],
              filePath: e['filePath'],
            ))
        .toList();
  }
 
  Future close() async {
    final db = await database;
    db.close();
  }
}
