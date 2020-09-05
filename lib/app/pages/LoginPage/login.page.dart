import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ColorPalette _colorPallete = new ColorPalette();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _colorPallete.secondColor,
              _colorPallete.secondColorDark,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(),
      ),
    );
  }
}
