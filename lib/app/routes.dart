import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/pages/HomePage/home.page.dart';
import 'package:meu_querido_livro/app/pages/LoginPage/login.page.dart';
import 'package:meu_querido_livro/app/pages/SplashScreenPage/splash_screen.page.dart';
import 'package:meu_querido_livro/app/pages/UserRegisterPage/user_register.page.dart';

class RouteWidget {
  static const String SPLASH_ROUTE = '/splash_route';
  static const String HOME_ROUTE = '/home_route';
  static const String LOGIN_ROUTE = '/login_route';
  static const String REGISTER_USER_ROUTE = '/register_user_route';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;

    switch (settings.name) {
      case SPLASH_ROUTE:
        return MaterialPageRoute(
          builder: (_) => SplashScreenPage(),
        );
      case HOME_ROUTE:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case LOGIN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case REGISTER_USER_ROUTE:
        return MaterialPageRoute(
          builder: (_) => UserRegisterPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => SplashScreenPage(),
        );
    }
  }
}
