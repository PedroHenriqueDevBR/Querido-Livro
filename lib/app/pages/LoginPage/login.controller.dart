import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/routes.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/snackbar_default.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:asuka/asuka.dart' as asuka;

class LoginController {
  TextEditingController txtLogin = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  IPersonStorage personStorage = PersonFirebase();
  StringText textReference = StringText.changeTo(StringText.ENGLISH);
  ColorPalette colorPallete = new ColorPalette();

  void goToCreateUserPage(BuildContext context) {
    Navigator.pushNamed(context, RouteWidget.REGISTER_USER_ROUTE);
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, RouteWidget.HOME_ROUTE);
  }

  Future loggon(BuildContext context) async {
    String login = txtLogin.text;
    String password = txtPassword.text;

    if (login.isEmpty) {
      asuka.showSnackBar(SnackbarDefault().defaultMessage(textReference.enterMail));
      return;
    }
    if (password.isEmpty) {
      asuka.showSnackBar(SnackbarDefault().defaultMessage(textReference.enterPass));
      return;
    }
    await personStorage.signin(login, password).then((response) {
      goToHomePage(context);
    }).catchError((error) {
      print(error);
      String errorStr = error.toString();
      if (errorStr.contains('ERROR_INVALID_EMAIL')) {
        asuka.showSnackBar(SnackbarDefault().defaultMessage(textReference.invalidEmail));
      } else if (errorStr.contains('ERROR_USER_NOT_FOUND')) {
        asuka.showSnackBar(SnackbarDefault().defaultMessage(textReference.invalidCredential));
      } else if (errorStr.contains('ERROR_WRONG_PASSWORD')) {
        asuka.showSnackBar(SnackbarDefault().defaultMessage(textReference.invalidCredential));
      } else {
        asuka.showSnackBar(SnackbarDefault().defaultMessage(textReference.internalError));
      }
    });
  }
}
