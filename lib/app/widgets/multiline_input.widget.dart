import 'package:flutter/material.dart';

class MultilineInputWidget extends StatelessWidget {
  TextEditingController controller;
  String hint;
  Function validator;

  MultilineInputWidget(this.controller, this.hint, {this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      expands: false,
      minLines: 5,
      maxLines: 10,
      cursorColor: Colors.black,
      controller: controller,
      validator: validator,
      style: TextStyle(
          color: Colors.black, decorationColor: Colors.black, fontSize: 17),
      decoration: InputDecoration(
        labelText: hint,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder()),
    );
  }
}
