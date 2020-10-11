import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/routes.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  StringText _stringText = StringText.changeTo(StringText.ENGLISH);
  ColorPalette _colorPalette = ColorPalette();
  IPersonStorage _storage = PersonFirebase();

  changePage() {
    Timer(Duration(milliseconds: 50), () {
      verifyLoggedUser();
    });
  }

  Future verifyLoggedUser() async {
    try {
      PersonModel person = await _storage.getLoggedUser();
      print('Person detail');
      print(person.toString());
      if (person.id != null) {
        Navigator.pushReplacementNamed(context, RouteWidget.HOME_ROUTE);
      } else {
        Navigator.pushReplacementNamed(context, RouteWidget.LOGIN_ROUTE);
      }
    } catch(error) {
      print(error);
      Navigator.pushReplacementNamed(context, RouteWidget.LOGIN_ROUTE);
    }
  }

  @override
  void initState() {
    changePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.brown, BlendMode.multiply),
            image: AssetImage('assets/images/splash-imge.jpeg'),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    height: 100,
                    image: AssetImage('assets/images/escola.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    _stringText.appName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  CircularProgressIndicator(
                    backgroundColor: _colorPalette.lightColor,
                    semanticsLabel: '${_stringText.loading}...',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
