import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/course_list.dart';
import '../models/list_item.dart';

class DbHelper {
  final int version = 1;
  Database db;
  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'courses.bd'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
        database.execute(
            'CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, name TEXT, quantity TEXT, note TEXT, ' +
                ' FOREIGN KEY(idList) REFRENCES lists(id)');
      }, version: version);
    }
    return db;
  }

  Future testDb() async {
    db = await openDb();
    await db.execute('INSERT INTO lists values(0,"Fruit, 2")');
    await db.execute(
        'INSERT INTO items values(0,0,"pomme", "2 kg", "Meilleur si ells sont vertes")');
    List lists = await db.rawQuery('SELECT * FROM lists');
    List items = await db.rawQuery('SELECT * FROM items');
    print(lists[0].toString());
    print(items[0].toString());
  }

  Future<int> insertList(CourseList list) async {
    int id = await this.db.insert('lists', list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> insertItem(ListItem item) async {
    int id = await this.db.insert('items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<CourseList>> getLists() async {
    final List<Map<String,dynamic>> maps = await db.query('lists');
    return List.generate(maps.length, (i){
      return 
      CourseList(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['priority'],
      );
    });
  }
}
