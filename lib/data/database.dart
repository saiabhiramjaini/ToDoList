import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{
  List todoList = [];  //all the todo tasks will be stored in this list
  final _mybox = Hive.box('mybox');

  void createInitialData(){
    //whenever a use opens the app for first time then this data will be displayed
  }

  void loadData(){
    todoList = _mybox.get("TODOLIST"); // using .get we can retreive the value at given key
  }

  void updateData(){
    _mybox.put("TODOLIST",todoList);  //using .put we need to mention key and value 
    //_mybox.add(todoList);           // using .add we need to mention only value key will be auto incremented
  }
}