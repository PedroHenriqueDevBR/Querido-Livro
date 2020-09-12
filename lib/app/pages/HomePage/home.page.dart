import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/pages/HomePage/home.controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: _appBarWidget(),
          body: model.pages[model.currentIndex],
          bottomNavigationBar: _bottomNavigation(),
        );
      },
    );
  }

  AppBar _appBarWidget() {
    HomeController homeController = Provider.of<HomeController>(context);

    return AppBar(
      leading: Icon(Icons.book),
      title: Text(
        homeController.textReference.appName,
        style: TextStyle(color: homeController.colorPalette.lightColor),
      ),
      centerTitle: true,
      actions: <Widget>[
        PopupMenuButton<int>(
          elevation: 6,
          icon: Icon(Icons.more_vert),
          color: homeController.colorPalette.lightColor,
          captureInheritedThemes: true,
          tooltip: 'Menu',
          offset: Offset(0, 100),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text('Deslogar'),
              height: 30,
            ),
          ],
          onSelected: (int value) {
            if (value == 1) {
              homeController.logout(context);
            }
          },
        ),
      ],
    );
  }

  BottomNavigationBar _bottomNavigation() {
    HomeController homeController = Provider.of<HomeController>(context);

    return BottomNavigationBar(
      currentIndex: homeController.currentIndex,
      backgroundColor: homeController.colorPalette.primaryColor,
      elevation: 0,
      fixedColor: homeController.colorPalette.lightColor,
      selectedIconTheme: IconThemeData(color: homeController.colorPalette.lightColor),
      unselectedIconTheme: IconThemeData(color: Colors.grey[100]),
      unselectedItemColor: Colors.grey[100],
      showUnselectedLabels: false,
      onTap: homeController.changePage,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(homeController.textReference.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          title: Text(homeController.textReference.books),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text(homeController.textReference.profile),
        ),
      ],
    );
  }
}
