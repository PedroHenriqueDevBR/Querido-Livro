import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meu_querido_livro/app/pages/HomePage/home.controller.dart';
import 'package:meu_querido_livro/app/pages/ListBooksPage/list_book.controller.dart';
import 'package:meu_querido_livro/app/pages/LoginPage/login.controller.dart';
import 'package:meu_querido_livro/app/pages/LoginPage/login.page.dart';
import 'package:meu_querido_livro/app/pages/UserRegisterPage/user_register.controlelr.dart';
import 'package:meu_querido_livro/app/routes.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:asuka/asuka.dart' show builder;
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        Provider<LoginController>.value(value: LoginController()),
        Provider<UserRegisterController>.value(value: UserRegisterController()),
        ChangeNotifierProvider<HomeController>.value(value: HomeController()),
        ChangeNotifierProvider<ListBookController>.value(value: ListBookController()),
      ],
      child: MaterialApp(
        title: 'Meu Querido Livro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: myAppBarTheme(),
        ),
        home: LoginPage(),
        builder: builder,
        initialRoute: RouteWidget.SPLASH_ROUTE,
        onGenerateRoute: RouteWidget.generateRoute,
      ),
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
