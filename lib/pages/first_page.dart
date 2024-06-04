// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/data/database.dart';
import 'package:project/util/dialog_box.dart';

import '../util/todo_Tile.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  //REFERENCE THE BOX
  final _myBox = Hive.box("my_box");

  //TEXT EDITING CONTROLLER TO STORE THE USER INPUT
  final my_Controller = TextEditingController();

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // FIRST TIME EVER OPENING THE APP THEN CREATE THE DATA
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else{
      //THERE ALREADY DATA THAT EXISTS
      db.loadData();
    }


    super.initState();
  }

  // CHECKBOX CHANGE METHOD
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  //METHOD TO SAVE THE TASK
  void saveNewTask() {
    setState(() {
      db.todoList.add([my_Controller.text, false]);
      my_Controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // CREATE NEW TASK METHOD
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          myController: my_Controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //DELETE TASK METHOD
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Center(
          child: Text(
            'HOME PAGE',
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}

/*

@NAVIGATION ---> TO NAVIGATE TO THE DIFFERENT PAGES WE CAN USE NAVIGATOR.PUSH METHOD OR WE CAN SPECIFY DIFFERENT ROUTES TO OUR PAGES.

#ROUTES:-
IN HOME PAGE TO DIRECTLY NAVIGATE TO THE FIRST PAGE
import 'package:project/pages/first_page.dart';
home : FirstPage(),

IN FIRST PAGE
import 'package:project/pages/second_page.dart';
body: Center(
        child: ElevatedButton(
          child: Text("GO TO NEXT PAGE",style: TextStyle(color: Colors.black),),
          onPressed: (){
            // USER PRESS IT AN GOES TO SECOND PAGE
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondPage(),
              ),
            );
          },
        ),
      ),
                  OR
USING ROUTES
IN HOME PAGE USE ROUTES TO SPECIFY MULTIPLE PAGES ROUTES
import 'package:project/pages/first_page.dart';
import 'package:project/pages/second_page.dart';
home : FirstPage(),
      routes: {
        '/firstpage' : (context) => FirstPage(),
        '/secondpage' : (context) => SecondPage(),
      },

IN FIRST PAGE USE NAVIGATOR.PUSHNAMED INSTEAD WHEN USING ROUTES IN THE HOME PAGE
body: Center(
        child: ElevatedButton(
          child: Text("GO TO NEXT PAGE",style: TextStyle(color: Colors.black),),
          onPressed: (){
            // USER PRESS IT AN GOES TO SECOND PAGE
            Navigator.pushNamed(context, '/secondpage');
          },
        ),
      ),

#DRAWER:-
IN THE FIRST PAGE USE DRAWER TO SELECT THE NEXT PAGES FROM THE SLIDING LEFT PANEL. IT ALSO CONTAINS CHILDRENS OF WIDGETS
AND
DRAWERHEADER IS USED TO GIVE AWAY OR LEAVE A EXTRA BIT OF SPACE WHEN PUTTING A LOGO OR ICON IN THE DRAWER
drawer: Drawer(
        backgroundColor: Colors.purple[100],
        child: Column(
          children: [
            // IT IS COMMON TO PLACE A DRAWER HEADER HERE!!
            DrawerHeader(
              child: Icon(
                Icons.favorite,
                size: 48,
              ),
            ),

            //HOME PAGE WITH LIST TILE
            ListTile(
              leading: Icon(Icons.home),
              title: Text("H O M E"),
              onTap: (){P
                //POP DRAWER FIRST
                Navigator.pop(context);

                //GO TO HOME PAGE
                Navigator.pushNamed(context, '/homepage');
              },
            ),

            //SETTINGS PAGE WITH LIST TILE
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("S E T T I N G S"),
              onTap: (){
                //POP DRAWER FIRST
                Navigator.pop(context);

                //GO TO SETTINGS PAGE
                Navigator.pushNamed(context, '/settingspage');
              },
            ),
          ],
        ),
      ),

#BOTTOM NAVIGATION BAR:-
USED TO NAVIGATE USING THE BOTTOM NAV BAR AND IT ALSO CONTAINS A LIST(items:[]) OF WIDGETS.

IN THE FIRST PAGE USE THE STATEFULL WIDGET INSTEAD OF STATELESS WIDGET BECAUSE WE WILL BE UPDATING AND ALSO SHOWING IN THE APP HTE UPDATION.

//THIS WILL KEEP THE TRACK OF THE CURRENT PAGE  <----- [VARIABLE]
  int selected_index = 0;

  //THIS METHOD WILL UPDATES THE INDEX  <----- [METHOD]
  void update(int index){
    //SET STATE REBUILTS THE WIDGETS
    setState(() {
      selected_index = index;
    });
  }

  //LIST OF PAGES WE HAVE IN OUR APP
  final List _pages = [              <----- [LIST]
    //home page
    HomePage(),

    //profile page
    ProfilePage(),

    //settings page
    SettingsPage(),

  ];

body: _pages[selected_index],   <------ [UI (USER INTERFACE)]
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selected_index,
        onTap: update,
        items: [
          // home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          // profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),

          // settings
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),

@STATE FULL WIDGETS ---> UPDATES ACCORDING TO THE CHANGE IN THE STATES AND ALSO REFLECTS THE CHANGE ON THE APP
@STATE LESS WIDGETS ---> ALWAYS REMAIN CONSTANT DOES NOT CHANGE AND DOES NOT REFLECT ON THE APP

@TEXT FIELD:-
USED TO LET USER TYPE WHATEVER THEY WANTS TO TYPE IN IT
AND
IT ALSO HAVE A TEXT EDITING CONTROLLER WHICH LETS US TO STORE THE INFORMATION USER TYPED IN THE TEXT FIELD
***HINT TEXT IS USED TO TELL THE USER WHAT TO TYPE IN IT***

  //TEXT EDITING CONTROLLER TO ACCESS WHAT USER TYPED
  TextEditingController mycontroller = TextEditingController();

  //METHOD TO GREET USER
  void greetuser(){
    print(mycontroller.text);
  }

  body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //TEXT FIELD
              TextField(
                controller: mycontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "TYPE YOUR NAME...",
                ),
              ),

              //BUTTON
              ElevatedButton(onPressed: greetuser, child: Text("TAP!!"),),

            ],
          ),
        ),
      ),

[TO DISPLAY THE TEXT ON THE SCREEN ]:-
WE CAN USE AN EMPTY STRING VARIABLE
AND
THEN UPDATE IT USING THE METHOD AND TEXT EDITING CONTROLLER

  //STRING TO STORE THE GREET MESSAGE
  String greetingMessage = "";

  //METHOD TO GREET USER
  void greetUser(){
    String userName = myController.text;

    setState(() {
      greetingMessage = "HELLO, $userName";
    });
  }

  //GREET USER MESSAGE DISPLAYED ON SCREEN
              Text(greetingMessage),

 */
