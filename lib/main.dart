// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/pages/first_page.dart';

void main() async{

  //INIT THE HIVE
  await Hive.initFlutter();

  //OPEN A BOX
  var box = await Hive.openBox("my_box");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : FirstPage(),
      // theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}




/*

@SCAFFOLD() --> IT IS A SKELETON WIDGET THAT HOLDS DIFFERENT PARTS OF THE APP
home : Scaffold(
        backgroundColor: Colors.deepPurple[500],

      ),

@CONTAINER() --> USED AS A FLEXIBLE WIDGET TO STORE VARIOUS DIFFERENT THINGS
body: Container(
          height: 300,
          width: 300,
          color: Colors.deepOrange,
        ),

**TO BRING IT IN CENTER WE NEED TO WRAP THE CONTAINER INTO THE CENTER WIDGET**
body: Center(
          child: Container(
            height: 300,
            width: 300,
            color: Colors.deepOrange,
          ),
        ),

**GIVE 'CHILD' TO PUT ANOTHER WIDGET INTO THE WIDGET**
body: Center(
          child: Container(
            height: 300,
            width: 300,
            color: Colors.deepOrange,
            padding: EdgeInsets.all(25),
            child: Text("HELLO THERE"),
          ),
        ),

**[
PADDING --> To give the space all around the text.
  THERE ARE MANY PADDING WAYS:-
    ALL         ---> TO DO PADDING IN ALL THE SPACES
    SYMMETRICAL ---> TO SPECIFY THE HORIZONTAL AND VERTICALS [sym]
    ONLY        ---> TO SPECIFY FOR ONLY A PARTICULAR DIRECTION

DECORATION ---> TO DECORATE FURTHER BUT
                ***YOU CANNOT PUT DECORATION AND COLOR DIFFERENTLY
                YOU NEED TO PUT COLOR INSIDE THE DECORATION ONLY***
body: Center(
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(25),
            child: Text(
              "HELLO THERE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

CURVE THE CORNERS ---->
   decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(20),
            ),
]**

@TEXT() ---> WIDGET USED TO PROVIDE TEXT INTO A CONTAINER WIDGET

style --> USED TO GIVE TEXT DIFFERENT STYLES
  child: Text(
            "HELLO THERE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

@ICONS ---> A WIDGET BY DEFAULT FLUTTER CONTAINS A LOT OF ICONS
child: Icon(
              Icons.favorite,
              color: Colors.blue,
              size: 45,
            ),

@APPBAR ---> IT IS A WIDGET WHICH IS AT THE TOP OF AN APP
appBar: AppBar(
  title: Text("MY APP"),
  backgroundColor: Colors.blue,
  elevation: 0,
),

elevation --> USED TO HIDE OR SHOW THE BOTTOM SHADOW
[
0 - TO HIDE AND MAKE IT FLAT
            OR
1 - TO SHOW THE ELEVATION
]

***
TO PUT AN ICON ON THE LEFT USE -
    leading: Icon(Icons.menu),

TO PUT AN ICON ON THE RIGHT USE -
    actions:[
             IT CONTAINS A LIST SO THAT WE CAN PUT MORE ICONS IN IT
            ],
    [EXG:-]
    actions: [
            IconButton(
             onPressed: () {},
             icon: Icon(Icons.logout)
             ),
          ],
***

@COLUMN ---> IT REQUIRES A CHILDREN OF MULTIPLE WIDGETS.IT IS USED TO DISPLAY WIDGETS IN A VERTICAL MANNER
body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1ST BOX
            Container(
              height: 200,
              width: 200,
              color: Colors.blue,
            ),

            // 2ND BOX
            Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),

            // 3RD BOX
            Container(
              height: 200,
              width: 200,
              color: Colors.green,
            ),
          ],
        ),

ALIGNMENT --->
  mainAxisAlignment: MainAxisAlignment.center/end/spaceBetween/spaceEvenly, [USED TO ALIGN THE WIDGETS IN THE COLUMN]
  crossAxisAlignment: CrossAxisAlignment.start/end/center, [USED TO ALIGN ALL THE OTHER WIDGETS ACCORDING TO THE BIGGEST WIDGET SIZE]

EXPANDED ---> USED TO FILL THE REST OF THE SPACES ACCORDING TO THE REST OF THE WIDGETS AND GOES WELL WITH COLUMNS AND ROWS.
Expanded(
  // 3RD BOX
  child:Container(
     height: 200,
     width: 200,
     color: Colors.green,
  ),
),

flex ---> IT IS USED TO ADJUST THE RATIO OF THE CURRENT WIDGET WITH RESPECT TO THE OTHER WIDGETS
Expanded(
  flex: 2,
  // 3RD BOX
  child:Container(
     height: 200,
     width: 200,
     color: Colors.green,
  ),
),

@LISTVIEW ---> IT IS SAME AS COLUMNS BUT WE CAN SCROLL TO SEE THE LAST OVERSIZED WIDGET IN THE APP
body: ListView(children:[Container(),],),

scrollDirection ---> WE CAN CONTROL THE SCROLL DIRECTION WITH IT.
body: ListView(
scrollDirection: Axis.horizontal,
children:[Container(),],
),

***WE CAN ALSO CREATE THE CHILDREN OF THE LISTVIEW BY USING THE BUILDER METHOD ON DEMAND.***
body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context,index) => ListTile(
            title: Text(index.toString()),
          ),
        ),
        OR
List names = ["RIDAM", "RAM"];
body: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context,index) => ListTile(
            title: Text(names[index]),
          ),
        ),

@GRIDVIEW ---> USED TO CREATE A GRID VIEW WIDGET AND CAN ALSO BE USED WITH BUILDER
body: GridView.builder(
            itemCount: 64,
            //gridDelegate --> HOW MANY IN EACH ROW
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (context,index) => Container(
              color: Colors.blue,
              margin: EdgeInsets.all(2),
            ),
        ),

itemCount: 64,
THIS TELLS THAT THE TOTAL WOULD BE 64

gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
IT TELLS THAT HOW MANY WE WANT IN EACH ROW


@STACK ---> ALSO CONTAINS A CHILDREN AND IS USED TO STACK DIFFERENT WIDGETS
            ON TOP OF OTHER WIDGET AND IT IS NOT USED WITH BUILDER.
            STACK ALSO HAVE ALIGNMENT PROPERTIES JUST LIKE THE COLUMNS AND ROWS
body: Stack(
          alignment: Alignment.center,
          children: [
            //BIG BOX
            Container(
              height: 300,
              width: 300,
              color: Colors.deepOrange,
            ),
            //MEDIUM BOX
            Container(
              height: 200,
              width: 200,
              color: Colors.deepOrange[200],
            ),
            //SMALL BOX
            Container(
              height: 100,
              width: 100,
              color: Colors.deepOrange[50],
            ),
          ],
        ),

@GESTUREDETECTOR ---> IT IS A WIDGET USED TO PERFORM SOME TASK WHEN INTERACTED BY THE USER.
body: Center(
          child: GestureDetector(
            onTap: () {
              //DO SOMETHING WHEN USER TAP ON IT
              print("USER TAPPED!!");
            },
            child: Container(
              height: 200,
              width: 200,
              color: Colors.deepOrange,
              child: Center(
                child: Text(
                  "TAP ME",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        OR
void usertapped(){
     print("USER TAPPED!!");
   }
body: Center(
          child: GestureDetector(
            onTap: usertapped,
            child: Container(
              height: 200,
              width: 200,
              color: Colors.deepOrange,
              child: Center(
                child: Text(
                  "TAP ME",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),

*/


/*

 VARIABLES: You can store different types of values into it.
 String name = "RIDAM";
 int age = 18;
 double pi = 3.17;
 bool isBeginner = true;


  BASIC MATH OPERATORS:
  1 + 1 = 2 , add
  1 - 1 = 0 , subtract
  1 * 1 = 1 , multiply
  4 / 2 = 2 , divide
  4 % 3 = 1 , remainder

  || --> OR operator

  if(cond.){
  }else{
  }

  else if(cond.){
  }

  switch(grade){
    case "A":
      print();
      break;
    default;
  }

  DATA STRUCTURES:

  //LIST --> IS AN ORDERED COLLECTION OF DATA, WE CAN HAVE DUPLICATES
  List numbers = [1,3,4,6];

  //LIST THAT STORES ONLY STRING
  List <String> numbers = ["R","A"];

  //LIST --> IS AN UNORDERED COLLECTION OF DATA, WE CANNOT HAVE DUPLICATES
  Set <String> names = {"R","A"};

  //MAP --> STORES AS A KEY-VALUE PAIR
  Map user = {
    'name' : "HELLO",
  };
  print(user['name']);

*/