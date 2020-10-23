import 'package:flutter/cupertino.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/snackbar_default.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:asuka/asuka.dart' as asuka;

class UserRegisterController {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtpass = TextEditingController();
  SnackbarDefault _snackbarDefault = SnackbarDefault();
  IPersonStorage _storage = PersonFirebase();
  StringText textReference = StringText.changeTo(StringText.DEFAULT);
  ColorPalette colorPallete = new ColorPalette();

  Future createUser() async {
    if (validForm()) {
      PersonModel person = PersonModel.create(txtName.text, '');
      person.email = txtEmail.text;
      person.password = txtpass.text;
      await _storage.createUser(person).then((response) async {
        _showMessage(textReference.verifyYourEmail);
        _clearFields();
      }).catchError((onError) {
        print(onError);
        _showMessage(textReference.internalError);
      });
    }
  }

  bool validForm() {
    String name = txtName.text;
    String email = txtEmail.text;

    if (name.isEmpty || email.isEmpty) {
      _showMessage(textReference.fillInTheFields);
      return false;
    }
    return true;
  }

  _showMessage(String msg) {
    asuka.showSnackBar(_snackbarDefault.defaultMessage(msg));
  }

  _clearFields() {
    txtName.clear();
    txtEmail.clear();
    txtpass.clear();
  }
}
