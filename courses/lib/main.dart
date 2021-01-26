import 'package:flutter/material.dart';
import './util/dbhelper.dart';
import './models/list_item.dart';
import './models/course_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DbHelper helper = DbHelper();
    helper.testDb();
    return MaterialApp(
      title: 'Liste de courses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShList(),
    );
  }
}

class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  DbHelper helper = DbHelper();
  Future showData() async {
    await helper.openDb();
    CourseList list = CourseList(0, 'Fraises', 2);
    
    /*
    int listId = await helper.insertList(list);
    ListItem item = ListItem(0, listId, 'Pain', 'note', '1kg');
    int itemId = await helper.insertItem(item);
    print('Id List:' + listId.toString());
    print('Id Item:' + itemId.toString());
    */
    courseList = await helper.getLists();
    setState((){
      courseList = courseList;
    });
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de courses'),
      ),
      body: ShList(),
    );
  }
}
