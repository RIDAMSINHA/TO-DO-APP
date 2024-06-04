import 'package:flutter/material.dart';
import 'package:project/util/button.dart';

class DialogBox extends StatelessWidget {

  final myController;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({super.key, required this.myController, required this.onSave, required this.onCancel,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        padding: const EdgeInsets.only(top: 24),
        height: 150,
        width: 300,
          child: Column(
            children: [
              //GET USER INPUT
              TextField(
                controller: myController,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),hintText: "TYPE HERE.."),
              ),

              const SizedBox(height: 17,),

              //BUTTONS (SAVE + CANCEL)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //SAVE BUTTON
                  MyButton(name: "SAVE", onPressed: onSave),

                  //EXTRA SPACE BETWEEN BUTTONS
                  const SizedBox(width: 8,),

                  //CANCEL BUTTON
                  MyButton(name: "CANCEL", onPressed: onCancel),
                ],
              )
            ],
          ),
        ),
    );
  }
}
