import 'package:flutter/material.dart';

class RegisterBookPage extends StatefulWidget {
  @override
  _RegisterBookPageState createState() => _RegisterBookPageState();
}

class _RegisterBookPageState extends State<RegisterBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registar livro'),
      ),
    );
  }
}
