import 'package:flutter/cupertino.dart';
import 'package:meu_querido_livro/app/interfaces/book_storage.interface.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/models/book.model.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';
import 'package:meu_querido_livro/app/repositories/book.repository.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/singleton/book.singleton.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';

class ListBookController extends ChangeNotifier {
  ColorPalette colorPalette = new ColorPalette();
  StringText textReferences = new StringText.changeTo(StringText.DEFAULT);
  IBookStorage _storage = BookFirebase();
  IPersonStorage _personStorage = PersonFirebase();
  bool loadedBooks = true;

  _finishLoadBooks() {
    loadedBooks = true;
    notifyListeners();
  }

  _initLoadBooks() {
    loadedBooks = false;
    notifyListeners();
  }

  Future getBooksFromDatabase() async {
    if (BookSingleton.instance.hasChange()) {
      _initLoadBooks();
      PersonModel person = await _personStorage.getLoggedUser();
      List<BookModel> responseBook = await _storage.getUserBooks(person);
      BookSingleton.instance.books = responseBook;
      notifyListeners();
      _finishLoadBooks();
    } else {
      notifyListeners();
    }
  }

  double getPercentPages(calc, total) {
    double percent = ((calc * 100) / total) / 100;
    return percent;
  }

  bool isUrlImageFromBook(BookModel book) {
    if (book.pictureUrl == null) {
      return false;
    } else if (book.pictureUrl.isEmpty) {
      return false;
    }
    return true;
  }

  String getAssetImageFromBook() {
    return 'assets/images/livro.png';
  }

  String getUrlImageFromBook(BookModel book) {
    return book.pictureUrl;
  }
}
