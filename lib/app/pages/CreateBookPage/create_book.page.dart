import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/book_storage.interface.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/models/book.model.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';
import 'package:meu_querido_livro/app/repositories/book.repository.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
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
  StringText _stringText = StringText.changeTo(StringText.ENGLISH);
  ColorPalette _colorPalette = ColorPalette();
  IBookStorage _storage = BookFirebase();
  IPersonStorage _personStorage = PersonFirebase();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtDescription = TextEditingController();
  TextEditingController _txtBookPageCount = TextEditingController();
  TextEditingController _txtReadPageCount = TextEditingController();
  TextEditingController _txtBorrowedReadPageCount = TextEditingController();
  String pictureUrl;
  bool enable = true;

  Future<String> getLoggedUser() async {
    PersonModel person = await _personStorage.getLoggedUser();
    return person.id;
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
      pictureUrl: pictureUrl,
      bookPageCount: bookPageCount,
      readPageCount: readPageCount,
      borrowedReadPageCount: borrowedReadPageCount,
      ownerId: owner,
      borrowedTo: null,
      enable: enable,
    );

    await _storage.createBook(bookRegister).then((BookModel bookResponse) {
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
    widget.book.pictureUrl = pictureUrl;
    widget.book.bookPageCount = bookPageCount;
    widget.book.readPageCount = readPageCount;
    widget.book.borrowedReadPageCount = borrowedReadPageCount;
    widget.book.enable = enable;

    await _storage.updateBook(widget.book).then((BookModel bookResponse) {
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
      pictureUrl = widget.book.pictureUrl;
      enable = widget.book.enable;
    }
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
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.34,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    height: 100,
                    image: AssetImage('assets/images/biblioteca.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Registrar livro',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
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
