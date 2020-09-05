import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meu_querido_livro/app/pages/HomePage/home.page.dart';
import 'package:meu_querido_livro/app/pages/LoginPage/login.page.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';

class App extends StatelessWidget {
  ColorPalette colorPalette = ColorPalette();

  void changeNavigatorColor() {
    dynamic systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: colorPalette.primaryColor,
      statusBarColor: colorPalette.primaryColor,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);
  }

  @override
  Widget build(BuildContext context) {
    changeNavigatorColor();
    return MaterialApp(
      title: 'Meu Querido Livro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: myAppBarTheme(),
      ),
      home: LoginPage(),
    );
  }

  AppBarTheme myAppBarTheme() {
    return AppBarTheme(
      brightness: Brightness.dark,
      color: colorPalette.primaryColor,
      actionsIconTheme: IconThemeData(color: colorPalette.lightColor),
      elevation: 0,
      iconTheme: IconThemeData(color: colorPalette.lightColor),
    );
  }
}
