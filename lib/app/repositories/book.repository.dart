import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meu_querido_livro/app/interfaces/book_storage.interface.dart';
import 'package:meu_querido_livro/app/models/book.model.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';
import 'package:meu_querido_livro/app/utils/constants.dart';

class BookFirebase implements IBookStorage {
  Firestore _firestore = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  Constants _constants = Constants();

  Future<List<BookModel>> getUserBooks(PersonModel person) async {
    try {
      List<BookModel> books = [];
      QuerySnapshot querySnapshot = await _firestore.collection(_constants.BOOK_DATABASE).where('ownerId', isEqualTo: person.id).getDocuments();
      for (DocumentSnapshot snapshot in querySnapshot.documents) {
        BookModel book = BookModel.fromJson(snapshot.data);
        book.id = snapshot.documentID;
        books.add(book);
      }
      return books;
    } catch (error) {
      print(error);
      return throw Exception(error);
    }
  }

  Future<BookModel> createBook(BookModel book) async {
    await _firestore.collection(_constants.BOOK_DATABASE).add(book.toJson()).then((DocumentReference documentReference) {
      book.id = documentReference.documentID;
      return book;
    }).catchError((onError) {
      print(onError);
      return throw Exception(onError);
    });
  }

  Future<BookModel> updateBook(BookModel book) async {
    await _firestore.collection(_constants.BOOK_DATABASE).document(book.id).setData(book.toJson()).then((_) {
      return book;
    }).catchError((onError) {
      print(onError);
      return throw Exception(onError);
    });
  }

  Future deleteBook(BookModel book) async {
    try {
      await _firestore.collection(_constants.BOOK_DATABASE).document(book.id).delete();
      return true;
    } catch (error) {
      print(error);
      return throw Exception(error);
    }
  }

  Future leanBook(BookModel book) async {
    return true;
  }
}
