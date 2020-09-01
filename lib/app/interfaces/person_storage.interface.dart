import 'dart:io';
import 'package:meu_querido_livro/app/models/person.model.dart';

abstract class IPersonStorage {
  Future createUser(PersonModel person);

  Future updateUser(PersonModel person, {File file});

  Future updateShopLogo(File profileImage, PersonModel person);

  Future<PersonModel> getLoggedUser();

  Future signin(String email, String pass);

  Future signout();
}
