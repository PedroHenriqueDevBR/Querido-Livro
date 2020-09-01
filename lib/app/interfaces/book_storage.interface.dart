import 'package:meu_querido_livro/app/models/book.model.dart';

abstract class IBookStorage {
  Future<BookModel> createBook(BookModel book);

  Future<BookModel> updateBook(BookModel book);

  Future deleteBook(BookModel book);

  Future leanBook(BookModel book);
}
