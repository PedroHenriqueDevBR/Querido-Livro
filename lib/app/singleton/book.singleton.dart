import 'package:meu_querido_livro/app/models/book.model.dart';

class BookSingleton {
  static BookSingleton _instance;
  List<BookModel> books = [];
  bool hasBookChange = true;

  BookSingleton._();

  static get instance {
    _instance ??= BookSingleton._();
    return _instance;
  }

  void addBook(BookModel book) {
    if (book != null) {
      this.books.add(book);
    } else {
      print('NULL BOOK ON ADD');
    }
  }

  void removeBook(BookModel book) {
    this.books.remove(book);
  }

  void updateBook(BookModel bookBase, BookModel bookUpdate) {
    if (bookBase != null && bookUpdate != null) {
      int index = this.books.indexOf(bookBase);
      books[index] = bookUpdate;
    } else {
      print('NULL BOOK ON UPDATE');
    }
  }

  bool hasChange() {
    if (this.hasBookChange) {
      this.hasBookChange = false;
      return true;
    }
    return false;
  }
}
