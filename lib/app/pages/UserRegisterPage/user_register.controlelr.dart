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
  TextEditingController txtRepeateEmail = TextEditingController();
  SnackbarDefault _snackbarDefault = SnackbarDefault();
  IPersonStorage _storage = PersonFirebase();
  StringText textReference = StringText.changeTo(StringText.DEFAULT);
  ColorPalette colorPallete = new ColorPalette();

  Future createUser() async {
    if (validForm()) {
      PersonModel person = PersonModel.create(txtName.text, '');
      person.email = txtEmail.text;
      DateTime datetime = DateTime.now();
      String key = '${txtEmail.text}${datetime.microsecond.toString()}'.replaceAll(' ', '');
      person.password = key;
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
    String repeateEmail = txtRepeateEmail.text;

    if (name.isEmpty || email.isEmpty || repeateEmail.isEmpty) {
      _showMessage(textReference.fillInTheFields);
      return false;
    } else if (email != repeateEmail) {
      _showMessage(textReference.differentEmails);
    }
    return true;
  }

  _showMessage(String msg) {
    asuka.showSnackBar(_snackbarDefault.defaultMessage(msg));
  }

  _clearFields() {
    txtName.text = '';
    txtEmail.text = '';
    txtRepeateEmail.text = '';
  }
}
