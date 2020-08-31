import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/pages/DashboardPage/dashboard.page.dart';
import 'package:meu_querido_livro/app/pages/ListBooksPage/list_book.page.dart';
import 'package:meu_querido_livro/app/pages/PersonConfigurationsPage/person_configurations.page.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ColorPalette _colorPalette = new ColorPalette();
  StringText _stringText = new StringText.changeTo(StringText.ENGLISH);
  int _currentIndex = 0;
  List<Widget> _pages = [
    DashboardPage(),
    ListBookPage(),
    PersonConfigurationsPage(),
  ];

  _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: Icon(Icons.book),
        title: Text(
          _stringText.appName,
          style: TextStyle(color: _colorPalette.lightColor),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          )
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  BottomNavigationBar _bottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      backgroundColor: _colorPalette.primaryColor,
      elevation: 0,
      fixedColor: _colorPalette.lightColor,
      selectedIconTheme: IconThemeData(color: _colorPalette.lightColor),
      unselectedIconTheme: IconThemeData(color: Colors.grey[100]),
      unselectedItemColor: Colors.grey[100],
      showUnselectedLabels: false,
      onTap: _changePage,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(_stringText.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          title: Text(_stringText.books),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text(_stringText.profile),
        ),
      ],
    );
  }
}
