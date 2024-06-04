import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{

  List todoList = [];

  //REFERENCE THE HIVE BOX
  final _myBox = Hive.box("my_box");

  //VERY FIRST TIME OPENING THE APP
  void createInitialData(){
    todoList = [
       ["MAKE TUTORIAL", true],
       ["DO HOMEWORK", false],
     ];
  }

  //LOAD THE DATA IN THE APP
  void loadData(){
    todoList = _myBox.get("TODOLIST");
  }

  //UPDATE THE DATABASE
  void updateDatabase(){
    _myBox.put("TODOLIST", todoList);
  }

}