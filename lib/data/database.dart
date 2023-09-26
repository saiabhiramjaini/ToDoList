import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{
  List todoList = [];
  final _mybox = Hive.box('mybox');

  void createInitialData(){
    
  }

  void loadData(){
    todoList = _mybox.get("TODOLIST");
  }

  void updateData(){
    _mybox.put("TODOLIST",todoList);
  }
}