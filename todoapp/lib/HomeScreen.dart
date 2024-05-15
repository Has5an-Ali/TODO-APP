import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'DialogBox.dart';
import 'ToDoList.dart';
import 'dataBase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _mybox = Hive.box('TaskBox');
  DataBase db = DataBase();

  @override
  void initState() {

   // If User Open First Time

    if(_mybox.get('TODO')==null){
      db.firstTimeData();
    }else{
      db.loadData();
    }

    super.initState();
  }

  //checkMethod
  void CheckBoxMethod(bool? value, int index) {
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];
    });
    db.updateDataBase();
  }

  //SaveTask
  void SaveTask() {
    setState(() {
      db.ToDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }


  //Delete Task

  void DeleteTask(int index){

    setState(() {
      db.ToDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  //createtask

  final _controller = TextEditingController();

  void createTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: SaveTask,
            onCancel: () {Navigator.pop(context);},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text(
          "TO DO",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        // backgroundColor: Colors.yellow,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: createTask,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
          itemCount:  db.ToDoList.length,
          itemBuilder: (context, index) {
            return TodoList(
              TaskName:  db.ToDoList[index][0],
              TaskComplete:  db.ToDoList[index][1],
              onChanged: (value) => CheckBoxMethod(value, index),
              deleteFunction: (context) => DeleteTask(index),
            );
          }),
    );
  }
}
