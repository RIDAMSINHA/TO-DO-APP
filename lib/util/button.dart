import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final String name;
  final VoidCallback onPressed;

  const MyButton({super.key, required this.name, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.yellow,
      child: Text(name),
    );
  }
}
