import 'package:flutter/material.dart';
import 'package:flutter_app/data/database.dart';
import 'package:flutter_app/utils/todo_tile.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();

  ToDoDataBase db = ToDoDataBase();

  final _myBox = Hive.box('myBox');

  void updateCheckBox(bool val, int index){
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  void createNewTask(){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text("Enter your task"),
          backgroundColor: Colors.yellow[200],
          content: TextField(
            controller: _textController,
          ),
          actions: [
            Row(
              children: [
                const Spacer(),
                MaterialButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: const Text("cancel"),
                  ),
                  const Spacer(),
                MaterialButton(
                  onPressed: (){
                    setState(() {
                      db.todoList.add([_textController.text,false]);
                    });
                    db.updateData();
                    _textController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text("submit"),
                  ),
                const Spacer()
              ],
            ),
          ],
        );
      }
    );
  }

  void deleteTask(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  void initState() {
    super.initState();
    if(_myBox.get("TODOLIST") == null)
    {
      db.createInitialData();
    }  
    else{
      db.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text("TO-DO LIST"),
        centerTitle: true,
        elevation: 0,
        ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context,index){
          return Column(
            children: [
              ToDoTile(
                taskName: db.todoList[index][0].toString(), 
                taskCompleted: db.todoList[index][1], 
                onChanged: (value)=>updateCheckBox(value!,index),
                deleteFunction: (context)=>deleteTask(index),
              ),
            ],
          );
        },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
        ),
    );
  }
}