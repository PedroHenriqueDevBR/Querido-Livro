import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/book_storage.interface.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/models/book.model.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';
import 'package:meu_querido_livro/app/repositories/book.repository.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/services/edit_image.service.dart';
import 'package:meu_querido_livro/app/services/get_image.service.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/snackbar_default.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';
import 'package:meu_querido_livro/app/widgets/multiline_input.widget.dart';
import 'package:meu_querido_livro/app/widgets/simple_input.widget.dart';

class CreateBookPage extends StatefulWidget {
  BookModel book;
  CreateBookPage({this.book = null});
  @override
  _CreateBookPageState createState() => _CreateBookPageState();
}

class _CreateBookPageState extends State<CreateBookPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  StringText _stringText = StringText.changeTo(StringText.ENGLISH);
  ColorPalette _colorPalette = ColorPalette();
  GetImageService _getImageService = GetImageService();
  EditImageService _editImageService = EditImageService();

  IBookStorage _storage = BookFirebase();
  IPersonStorage _personStorage = PersonFirebase();

  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtDescription = TextEditingController();
  TextEditingController _txtBookPageCount = TextEditingController();
  TextEditingController _txtReadPageCount = TextEditingController();
  TextEditingController _txtBorrowedReadPageCount = TextEditingController();
  bool enable = true;
  File imageFile;

  Future<String> getLoggedUser() async {
    PersonModel person = await _personStorage.getLoggedUser();
    return person.id;
  }

  Future getCameraImage() async {
    File receiveImage;
    receiveImage = await _getImageService.getImageFromCamera();
    setState(() {
      imageFile = receiveImage;
    });
  }

  Future getGalleryImage() async {
    File receiveImage;
    receiveImage = await _getImageService.getImageFromGallery();
    setState(() {
      imageFile = receiveImage;
    });
  }

  void _getImage() async {
    _globalKey.currentState.showBottomSheet(
      (context) => Padding(
        padding: EdgeInsets.all(16),
        child: Wrap(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Selecionar a image da:',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
                ButtonDefaultWidget('Câmera', () {
                  getCameraImage();
                  Navigator.pop(context);
                }, _colorPalette.secondColor),
                SizedBox(height: 16),
                ButtonDefaultWidget('Galeria', () {
                  getGalleryImage();
                  Navigator.pop(context);
                }, _colorPalette.secondColor),
                SizedBox(height: 16),
                Text(
                  'Arraste para baixo para cancelar:',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: _colorPalette.primaryColor,
      elevation: 6,
    );
  }

  void editImage() async {
    File editedImage;
    if (imageFile != null) {
      editedImage = await _editImageService.editImage(imageFile);
    } else {
      showErrorMessage('Selecione uma imagem para ser editada');
    }
    if (editedImage != null) {
      setState(() {
        imageFile = editedImage;
      });
    }
  }

  void reserImageData() {
    setState(() {
      imageFile = null;
      if (widget.book != null) {
        widget.book.pictureUrl = null;
      }
    });
  }

  bool validForm() {
    String name = _txtName.text;
    String description = _txtDescription.text;
    String bookPageCount = _txtBookPageCount.text;
    String readPageCount = _txtReadPageCount.text;

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
      if (widget.book == null) {
        createBook();
      } else {
        updateBook();
      }
    }
  }

  Future createBook() async {
    String name = _txtName.text;
    String description = _txtDescription.text;
    int bookPageCount = _txtBookPageCount.text != null ? int.parse(_txtBookPageCount.text) : 0;
    int readPageCount = _txtReadPageCount.text != null ? int.parse(_txtReadPageCount.text) : 0;
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

    await _storage.createBook(bookRegister, image: imageFile).then((BookModel bookResponse) {
      setState(() {
        widget.book = bookResponse;
      });
      showSuccessMessage('Cadastrado com sucesso!');
    }).catchError((error) {
      showErrorMessage('Ocorreu um erro ao registrar livro');
    });
  }

  Future updateBook() async {
    String name = _txtName.text;
    String description = _txtDescription.text;
    int bookPageCount = _txtBookPageCount.text != null ? int.parse(_txtBookPageCount.text) : 0;
    int readPageCount = _txtReadPageCount.text != null ? int.parse(_txtReadPageCount.text) : 0;
    int borrowedReadPageCount = 0;

    widget.book.name = name;
    widget.book.description = description;
    widget.book.pictureUrl = '';
    widget.book.bookPageCount = bookPageCount;
    widget.book.readPageCount = readPageCount;
    widget.book.borrowedReadPageCount = borrowedReadPageCount;
    widget.book.enable = enable;

    await _storage.updateBookImage(widget.book, file: imageFile).then((BookModel bookResponse) {
      setState(() {
        widget.book = bookResponse;
      });
      showSuccessMessage('Atualizado com sucesso!');
    }).catchError((error) {
      showErrorMessage('Ocorreu um erro ao registrar livro');
    });
  }

  initBookFormData() {
    if (widget.book != null) {
      _txtName.text = widget.book.name;
      _txtDescription.text = widget.book.description;
      _txtBookPageCount.text = widget.book.bookPageCount.toString();
      _txtReadPageCount.text = widget.book.readPageCount.toString();
      _txtBorrowedReadPageCount.text = widget.book.borrowedReadPageCount.toString();
      enable = widget.book.enable;
    }
  }

  double getImageSize() {
    double value = 100;
    if (imageFile != null) {
      value = MediaQuery.of(_globalKey.currentContext).size.width;
    } else if (widget.book != null) {
      if (widget.book.pictureUrl != null) {
        if (widget.book.pictureUrl.isNotEmpty) {
          value = MediaQuery.of(context).size.width;
        }
      }
    }
    return value;
  }

  showDefaultMessage(String message) {
    SnackBar snackBar = SnackbarDefault().defaultMessage(message);
    _globalKey.currentState.showSnackBar(snackBar);
  }

  showSuccessMessage(String message) {
    SnackBar snackBar = SnackbarDefault().successfulMessage(message);
    _globalKey.currentState.showSnackBar(snackBar);
  }

  showErrorMessage(String message) {
    SnackBar snackBar = SnackbarDefault().alertMessage(message);
    _globalKey.currentState.showSnackBar(snackBar);
  }

  Widget getImageWidget() {
    if (imageFile != null) {
      return Image(
        width: getImageSize(),
        image: FileImage(imageFile),
      );
    } else if (widget.book != null) {
      if (widget.book.pictureUrl != null) {
        if (widget.book.pictureUrl.isNotEmpty) {
          return Image(
            width: getImageSize(),
            image: NetworkImage(widget.book.pictureUrl),
          );
        }
      }
    }

    return Image(
      width: getImageSize(),
      image: AssetImage('assets/images/biblioteca.png'),
    );
  }

  @override
  void initState() {
    initBookFormData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Livro'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Remover\nimagem',
              style: TextStyle(color: _colorPalette.lightColor),
            ),
            onPressed: () {
              reserImageData();
            },
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _getImage();
                    },
                    onLongPress: () {
                      showDialog(
                        context: (context),
                        builder: (alertContext) => AlertDialog(
                          title: Text('Atenção'),
                          content: Text('Editar imagem selecionada?'),
                          actions: <Widget>[
                            FlatButton(
                                child: Text('Cancelar'),
                                onPressed: () {
                                  Navigator.pop(alertContext);
                                }),
                            FlatButton(
                              child: Text('Confirmar'),
                              onPressed: () {
                                editImage();
                                Navigator.pop(alertContext);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: getImageWidget(),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Precione a imagem para alterar-la',
                  textAlign: TextAlign.center,
                ),
                imageFile != null
                    ? Text(
                        'Precione e segure a imagem para editar a imagem selecionada',
                        textAlign: TextAlign.center,
                      )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                SimpleInputWidget(
                  _txtName,
                  'Nome do livro',
                  bordered: true,
                ),
                SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: SimpleInputWidget(
                      _txtReadPageCount,
                      'Páginas lidas',
                      bordered: true,
                    )),
                    SizedBox(width: 16),
                    Expanded(
                        child: SimpleInputWidget(
                      _txtBookPageCount,
                      'Número de páginas',
                      bordered: true,
                    )),
                  ],
                ),
                SizedBox(height: 16),
                MultilineInputWidget(_txtDescription, 'Descrição do livro'),
                SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Text('Livro ativo'),
                    Switch(
                        value: enable,
                        onChanged: (value) {
                          setState(() {
                            enable = value;
                          });
                        }),
                  ],
                ),
                SizedBox(height: 16),
                ButtonDefaultWidget('Registrar', () {
                  registerBook();
                }, _colorPalette.secondColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
