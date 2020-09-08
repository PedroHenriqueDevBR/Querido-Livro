import 'dart:io';

import 'package:meu_querido_livro/app/models/book.model.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';

abstract class IBookStorage {
  Future<List<BookModel>> getUserBooks(PersonModel person);

  Future<BookModel> createBook(BookModel book, {File image});

  Future<BookModel> updateBook(BookModel book);

  Future deleteBook(BookModel book);

  Future<BookModel> updateBookImage(BookModel book, {File file});
}
