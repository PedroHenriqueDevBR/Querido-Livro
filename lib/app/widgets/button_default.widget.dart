import 'package:flutter/material.dart';

class ButtonDefaultWidget extends StatelessWidget {
  String text;
  Function action;
  Color color;

  ButtonDefaultWidget(this.text, this.action, this.color);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(16),
      color: color,
      textColor: Colors.white,
      minWidth: MediaQuery.of(context).size.width,
      child: Text(text),
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.all(
//          Radius.circular(8.0),
//        ),
//      ),
      onPressed: action,
    );
  }
}
