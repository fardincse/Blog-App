import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  DatabaseHelper._();
  static DatabaseHelper getIntance = DatabaseHelper._();

  static Database? _database;

  //get Database
  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('my_bookmarks.db');
    return _database!;
  }

  //init Database
  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //create Database
  Future _createDB(Database db, int version) async{
    await db.execute('''
      CREATE TABLE MY_BOOKMARKS(
        sl INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        image TEXT NOT NULL
      )
''');
  }

  //Insert into bookmarks
  Future insertBookMark(Map<String, dynamic> row) async{
    final db = await getIntance.database;
    return await db.insert('MY_BOOKMARKS', row); 
  }

  //Get bookmarks from DB
  Future<List<Map<String, dynamic>>> fetchBookmarks() async{
    final db = await getIntance.database;
    return db.query('MY_BOOKMARKS');
  }

  //bookmarks item check
  Future<bool> isBookmarks(int id) async{
    final db = await getIntance.database;
    final bookmark = await db.query('MY_BOOKMARKS', where: 'id = ?', whereArgs: [id]);
    return bookmark.isNotEmpty;
  }

  //Delete bookmarks from DB
  Future deleteBookmarks(int id) async{
    final db = await getIntance.database;
    return db.delete('MY_BOOKMARKS', where: 'id = ?', whereArgs: [id]);
  }

  //close DB
  Future close() async{
    final db = await getIntance.database;
    db.close();
  }
}