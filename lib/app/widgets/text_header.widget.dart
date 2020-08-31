import 'package:flutter/material.dart';

class TextHeaderWidget extends StatelessWidget {
  String text;
  TextHeaderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),
      ),
    );
  }
}
