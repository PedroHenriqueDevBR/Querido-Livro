import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/pages/DashboardPage/dashboard.page.dart';
import 'package:meu_querido_livro/app/pages/ListBooksPage/list_book.page.dart';
import 'package:meu_querido_livro/app/pages/UserConfigurationsPage/user_configurations.page.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/routes.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';

class HomeController extends ChangeNotifier {
  ColorPalette colorPalette = new ColorPalette();
  StringText textReference = new StringText.changeTo(StringText.DEFAULT);
  int currentIndex = 0;
  List<Widget> pages = [
    DashboardPage(),
    ListBookPage(),
    UserConfigurationsPage(),
  ];

  IPersonStorage _personStorage = PersonFirebase();

  Future logout(BuildContext context) async {
    await _personStorage.signout().then((_) {
      Navigator.pushReplacementNamed(context, RouteWidget.SPLASH_ROUTE);
    }).catchError((error) {
      print(error);
    });
  }

  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void goToLanguage(BuildContext context) {
    Navigator.pushNamed(context, RouteWidget.SELECT_LANGUAGE_ROUTE);
  }
}
