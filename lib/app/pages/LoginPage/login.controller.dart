import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/routes.dart';
import 'package:meu_querido_livro/app/utils/snackbar_default.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:asuka/asuka.dart' as asuka;

class LoginController {
  TextEditingController txtLogin = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  IPersonStorage storage = PersonFirebase();
  StringText stringText = StringText.changeTo(StringText.ENGLISH);

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
      asuka.showSnackBar(SnackbarDefault().defaultMessage(stringText.enterMail));
      return;
    }
    if (password.isEmpty) {
      asuka.showSnackBar(SnackbarDefault().defaultMessage(stringText.enterPass));
      return;
    }
    await storage.signin(login, password).then((response) {
      goToHomePage(context);
    }).catchError((error) {
      print(error);
      String errorStr = error.toString();
      if (errorStr.contains('ERROR_INVALID_EMAIL')) {
        asuka.showSnackBar(SnackbarDefault().defaultMessage(stringText.invalidEmail));
      } else if (errorStr.contains('ERROR_USER_NOT_FOUND')) {
        asuka.showSnackBar(SnackbarDefault().defaultMessage(stringText.invalidCredential));
      } else if (errorStr.contains('ERROR_WRONG_PASSWORD')) {
        asuka.showSnackBar(SnackbarDefault().defaultMessage(stringText.invalidCredential));
      } else {
        asuka.showSnackBar(SnackbarDefault().defaultMessage(stringText.internalError));
      }
    });
  }
}
