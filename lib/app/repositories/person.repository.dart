import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';
import 'package:meu_querido_livro/app/utils/constants.dart';

class PersonFirebase implements IPersonStorage {
  Firestore _firestore = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  Constants _constants = Constants();

  @override
  Future createUser(PersonModel person) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: person.email,
        password: person.password,
      ).then((value) async {
        await createUserData(person).then((value) {
          return true;
        });
      }).catchError((error) {
        return throw Exception(error);
      });
    } catch (error) {
      return throw Exception(error);
    }
  }

  Future createUserData(PersonModel person) async {
    try {
      await _auth.currentUser().then((value) async {
        String id = value.uid;
        if (id != null) {
          _firestore.collection(_constants.PERSON_DATABASE).document(id).setData(person.toJson());
          return true;
        } else {
          return throw Exception('Erro ao cadastrar usuário entre em contato com o desenvolvedor');
        }
      });
    } catch (error) {
      return throw Exception(error);
    }
  }

  Future updatePassword(PersonModel person) async {
    await _auth.sendPasswordResetEmail(email: person.email).then((_) {
      return true;
    }).catchError((onError) {
      return throw Exception('Erro ao resetar senha');
    });
  }

  @override
  Future<PersonModel> getLoggedUser() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      String id = user.uid;
      DocumentSnapshot snapshot = await _firestore.collection(_constants.PERSON_DATABASE).document(id).get();
      PersonModel person = PersonModel.fromJson(snapshot.data);
      person.id = id;
      return person;
    } catch (error) {
      return throw Exception(error);
    }
  }

  @override
  Future updateShopLogo(File profileImage, PersonModel person) async {
    try {
      StorageReference root = _storage.ref();
      StorageReference file = root.child(_constants.PERSON_IMAGE_DATABASE).child('${person.id}.jpg');
      StorageUploadTask uploadTask = file.putFile(profileImage);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    } catch (error) {
      return throw Exception(error);
    }
  }

  @override
  Future<PersonModel> updateUser(PersonModel person, {File file}) async {
    if (file != null) {
      await updateShopLogo(file, person).then((imageUrl) {
        person.pictureUrl = imageUrl;
      }).catchError((error) {
        return throw Exception('erro ao carregar imagem');
      });
    }

    try {
      await _firestore.collection(_constants.PERSON_DATABASE).document(person.id).setData(person.toJson());
      return person;
    } catch (error) {
      return throw Exception(error);
    }
  }

  @override
  Future signin(String email, String pass) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: pass,
      )
          .then((value) {
        return value;
      }).catchError((error) {
        return throw Exception(error);
      });
    } catch (error) {
      return throw Exception(error);
    }
  }

  @override
  Future signout() async {
    try {
      await _auth.signOut().then((_) {
        return true;
      }).catchError((error) {
        return throw Exception(error);
      });
    } catch (error) {
      return throw Exception(error);
    }
  }
}
