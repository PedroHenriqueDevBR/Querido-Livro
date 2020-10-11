import 'dart:io';

import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/book_storage.interface.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/models/book.model.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';
import 'package:meu_querido_livro/app/repositories/book.repository.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/services/edit_image.service.dart';
import 'package:meu_querido_livro/app/services/get_image.service.dart';
import 'package:meu_querido_livro/app/singleton/book.singleton.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/snackbar_default.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';

class CreateBookController extends ChangeNotifier {
  StringText textReference = StringText.changeTo(StringText.ENGLISH);
  ColorPalette colorPalette = ColorPalette();
  GetImageService _getImageService = GetImageService();
  EditImageService _editImageService = EditImageService();

  BookModel currentBook;
  IBookStorage _storage = BookFirebase();
  IPersonStorage _personStorage = PersonFirebase();

  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtBookPageCount = TextEditingController();
  TextEditingController txtReadPageCount = TextEditingController();
  TextEditingController txtBorrowedReadPageCount = TextEditingController();
  bool enable = true;
  File imageFile;

  Future<String> getLoggedUser() async {
    PersonModel person = await _personStorage.getLoggedUser();
    return person.id;
  }

  Future getGalleryImage() async {
    File receiveImage;
    receiveImage = await _getImageService.getImageFromGallery();
    imageFile = receiveImage;
    notifyListeners();
  }

  void getImage() async {
    getGalleryImage();
  }

  void editImage() async {
    File editedImage;
    if (imageFile != null) {
      editedImage = await _editImageService.editImage(imageFile);
    } else {
      showErrorMessage('Selecione uma imagem para ser editada');
    }
    if (editedImage != null) {
      imageFile = editedImage;
      notifyListeners();
    }
  }

  void resetImageData() {
    imageFile = null;
    if (currentBook != null) {
      currentBook.pictureUrl = null;
    }
    notifyListeners();
  }

  bool validForm() {
    String name = txtName.text;
    String description = txtDescription.text;
    String bookPageCount = txtBookPageCount.text;
    String readPageCount = txtReadPageCount.text;

    if (name.isEmpty || description.isEmpty || bookPageCount.isEmpty || readPageCount.isEmpty) {
      showDefaultMessage('Preencha todos os campos para cadastrar o livro');
      return false;
    } else {
      int intBookPageCount = int.parse(bookPageCount);
      int intReadPageCount = int.parse(readPageCount);
      if (intBookPageCount < intReadPageCount) {
        showDefaultMessage('O número de páginas lidas não pode ser superior ao número de páginas do livro');
        return false;
      }
      return true;
    }
  }

  void registerBook() {
    if (validForm()) {
      if (currentBook == null) {
        createBook();
      } else {
        updateBook();
      }
    }
  }

  Future createBook() async {
    String name = txtName.text;
    String description = txtDescription.text;
    int bookPageCount = txtBookPageCount.text != null ? int.parse(txtBookPageCount.text) : 0;
    int readPageCount = txtReadPageCount.text != null ? int.parse(txtReadPageCount.text) : 0;
    int borrowedReadPageCount = 0;
    String owner = await getLoggedUser();

    BookModel bookRegister = BookModel(
      name: name,
      description: description,
      pictureUrl: null,
      bookPageCount: bookPageCount,
      readPageCount: readPageCount,
      borrowedReadPageCount: borrowedReadPageCount,
      ownerId: owner,
      borrowedTo: null,
      enable: enable,
    );

    try {
      BookModel bookResponse = await _storage.createBook(bookRegister, image: imageFile);
      currentBook = bookResponse;
      addToSingletonBook(bookResponse);
      notifyListeners();
      showSuccessMessage('Cadastrado com sucesso!');
    } catch(error) {
      print(error);
      return throw Exception('Erro ao cadastrar livro');
    }
  }

  Future updateBook() async {
    String name = txtName.text;
    String description = txtDescription.text;
    int bookPageCount = txtBookPageCount.text != null ? int.parse(txtBookPageCount.text) : 0;
    int readPageCount = txtReadPageCount.text != null ? int.parse(txtReadPageCount.text) : 0;
    int borrowedReadPageCount = 0;

    currentBook.name = name;
    currentBook.description = description;
    currentBook.pictureUrl = '';
    currentBook.bookPageCount = bookPageCount;
    currentBook.readPageCount = readPageCount;
    currentBook.borrowedReadPageCount = borrowedReadPageCount;
    currentBook.enable = enable;

    await _storage.updateBookImage(currentBook, file: imageFile).then((BookModel bookResponse) {
      updateToSingletonBook(currentBook, bookResponse);
      currentBook = bookResponse;
      notifyListeners();
      showSuccessMessage('Atualizado com sucesso!');
    }).catchError((error) {
      showErrorMessage('Ocorreu um erro ao registrar livro');
    });
  }

  Future deleteBook(BuildContext context) async {
    if (currentBook != null) {
      _storage.deleteBook(currentBook).then((_) {
        removeToSingletonBook(currentBook);
        Navigator.pop(context);
      });
    } else {
      showErrorMessage('Operação impossível');
    }
  }

  initBookFormData(BookModel book) {
    currentBook = book;
    if (currentBook != null) {
      txtName.text = currentBook.name != null ? currentBook.name : '';
      txtDescription.text = currentBook.description != null ? currentBook.description : '';
      txtBookPageCount.text = currentBook.bookPageCount != null ? currentBook.bookPageCount.toString() : '';
      txtReadPageCount.text = currentBook.readPageCount != null ? currentBook.readPageCount.toString() : '';
      txtBorrowedReadPageCount.text = currentBook.borrowedReadPageCount != null ? currentBook.borrowedReadPageCount.toString() : '';
      enable = currentBook.enable != null ? currentBook.enable : false;
      notifyListeners();
    } else {
      imageFile = null;
      txtName.text = '';
      txtDescription.text = '';
      txtBookPageCount.text = '';
      txtReadPageCount.text = '';
      txtBorrowedReadPageCount.text = '';
      enable = false;
      notifyListeners();
    }
  }

  double getImageSize(BuildContext context) {
    double value = 100;
    if (imageFile != null) {
      value = MediaQuery.of(context).size.width;
    } else if (currentBook != null) {
      if (currentBook.pictureUrl != null) {
        if (currentBook.pictureUrl.isNotEmpty) {
          value = MediaQuery.of(context).size.width;
        }
      }
    }
    return value;
  }

  void addToSingletonBook(BookModel book) {
    BookSingleton.instance.addBook(book);
  }

  void removeToSingletonBook(BookModel book) {
    BookSingleton.instance.removeBook(book);
  }

  void updateToSingletonBook(BookModel bookBase, BookModel bookUpdate) {
    BookSingleton.instance.updateBook(bookBase, bookUpdate);
  }

  showDefaultMessage(String message) {
    SnackBar snackBar = SnackbarDefault().defaultMessage(message);
    asuka.showSnackBar(snackBar);
  }

  showSuccessMessage(String message) {
    SnackBar snackBar = SnackbarDefault().successfulMessage(message);
    asuka.showSnackBar(snackBar);
  }

  showErrorMessage(String message) {
    SnackBar snackBar = SnackbarDefault().alertMessage(message);
    asuka.showSnackBar(snackBar);
  }

  Widget getImageWidget(BuildContext context) {
    if (imageFile != null) {
      return Image(
        width: getImageSize(context),
        image: FileImage(imageFile),
      );
    } else if (currentBook != null) {
      if (currentBook.pictureUrl != null) {
        if (currentBook.pictureUrl.isNotEmpty) {
          return Image(
            width: getImageSize(context),
            image: NetworkImage(currentBook.pictureUrl),
          );
        }
      }
    }

    return Image(
      width: getImageSize(context),
      image: AssetImage('assets/images/biblioteca.png'),
    );
  }
}
