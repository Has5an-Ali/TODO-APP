
import 'package:hive/hive.dart';

class DataBase{

  List ToDoList= [];

  final _mybox = Hive.box('TaskBox');



  // 1st Time User Open App
    void firstTimeData(){
      ToDoList = [
        ['Keep Workings ' , false],
        ["Keep Workings " , false]
      ];
    }


    // For Loading Data

    void loadData(){
      ToDoList = _mybox.get("TODO");
    }
    //Update The Current DataBase
    void updateDataBase(){

      _mybox.put("TODO", ToDoList);
    }

}

//
// List ToDoList = [
//   ["Make Tutorials ", false],
//   ["Do Workings", false]
// ];