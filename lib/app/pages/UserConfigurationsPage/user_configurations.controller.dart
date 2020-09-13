import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/images_name.dart';
import 'package:meu_querido_livro/app/utils/snackbar_default.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:asuka/asuka.dart' as asuka;

class UserConfigurationsController extends ChangeNotifier {
  ColorPalette colorPalette = new ColorPalette();
  StringText textReference = new StringText.changeTo(StringText.ENGLISH);
  ImagesName imagesName = ImagesName();

  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  PersonModel currentPerson;

  IPersonStorage _storage = PersonFirebase();

  Future getLoggedUser() async {
    if (currentPerson == null) {
      currentPerson = await _storage.getLoggedUser();
      txtName.text = currentPerson.name;
      txtDescription.text = currentPerson.description;
      notifyListeners();
    }
  }

  bool _validUpdateUserDataForm() {
    if (txtName.text.isEmpty || txtDescription.text.isEmpty) {
      showMessage('Preencha todos os campos');
      return false;
    }
    return true;
  }

  Future updateUserData() async {
    if (_validUpdateUserDataForm()) {
      try {
        PersonModel person = currentPerson;
        person.name = txtName.text;
        person.description = txtDescription.text;
        PersonModel personResponse = await _storage.updateUser(person);
        currentPerson = personResponse;
        notifyListeners();
        showMessage('Dados atualizados');
      } catch (error) {
        print(error);
      }
    }
  }

  void showMessage(String text) {
    SnackBar snackbar = SnackbarDefault().defaultMessage(text);
    asuka.showSnackBar(snackbar);
  }
}
