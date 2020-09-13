import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/models/book.model.dart';
import 'package:meu_querido_livro/app/pages/CreateBookPage/create_book.controller.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';
import 'package:meu_querido_livro/app/widgets/multiline_input.widget.dart';
import 'package:meu_querido_livro/app/widgets/simple_input.widget.dart';
import 'package:provider/provider.dart';

class CreateBookPage extends StatefulWidget {
  BookModel book;
  CreateBookPage({this.book = null});
  @override
  _CreateBookPageState createState() => _CreateBookPageState();
}

class _CreateBookPageState extends State<CreateBookPage> {
  void initBookFormData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CreateBookController>(context, listen: false).initBookFormData(widget.book);
    });
  }

  @override
  void initState() {
    initBookFormData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }

  AppBar _appBarWidget() {
    CreateBookController createBookController = Provider.of<CreateBookController>(context);
    return AppBar(
      title: Text('Livro'),
      centerTitle: true,
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Remover\nimagem',
            style: TextStyle(color: createBookController.colorPalette.lightColor),
          ),
          onPressed: () {
            createBookController.resetImageData();
          },
        ),
      ],
    );
  }

  Widget _bodyWidget() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        _craeteBookImageWidget(),
        _containerFormCreateBook(),
      ],
    );
  }

  Widget _craeteBookImageWidget() {
    CreateBookController createBookController = Provider.of<CreateBookController>(context);
    return Container(
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
                createBookController.getImage();
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
                          createBookController.editImage();
                          Navigator.pop(alertContext);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: createBookController.getImageWidget(context),
            ),
          ),
          SizedBox(height: 16),
          _textInfoWidget('Precione a imagem para alterar-la'),
          createBookController.imageFile != null ? _textInfoWidget('Precione e segure a imagem para editar a imagem selecionada') : Container(),
        ],
      ),
    );
  }

  Widget _containerFormCreateBook() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: _formCreateBook(),
    );
  }

  Widget _formCreateBook() {
    CreateBookController createBookController = Provider.of<CreateBookController>(context);
    return Column(
      children: <Widget>[
        SimpleInputWidget(
          createBookController.txtName,
          'Nome do livro',
          bordered: true,
        ),
        SizedBox(height: 16),
        Row(
          children: <Widget>[
            Expanded(
                child: SimpleInputWidget(
              createBookController.txtReadPageCount,
              'Páginas lidas',
              bordered: true,
            )),
            SizedBox(width: 16),
            Expanded(
                child: SimpleInputWidget(
              createBookController.txtBookPageCount,
              'Número de páginas',
              bordered: true,
            )),
          ],
        ),
        SizedBox(height: 16),
        MultilineInputWidget(createBookController.txtDescription, 'Descrição do livro'),
        SizedBox(height: 16),
        Row(
          children: <Widget>[
            Text('Livro ativo'),
            Switch(
                value: createBookController.enable,
                onChanged: (value) {
                  setState(() {
                    createBookController.enable = value;
                  });
                }),
          ],
        ),
        SizedBox(height: 16),
        _groupActionButton(),
      ],
    );
  }

  /*
   * auxiliary widget
   */
  Text _textInfoWidget(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
    );
  }

  Widget _groupActionButton() {
    CreateBookController createBookController = Provider.of<CreateBookController>(context);
    return Row(
      children: <Widget>[
        _buttonDeleteBookWidget(),
        createBookController.currentBook != null ? SizedBox(width: 16) : Container(),
        _buttonCraeteBookWidget(),
      ],
    );
  }

  Widget _buttonDeleteBookWidget() {
    CreateBookController createBookController = Provider.of<CreateBookController>(context);
    return createBookController.currentBook != null
        ? Expanded(
            child: ButtonDefaultWidget('Deletar', () {
              createBookController.deleteBook(context);
            }, createBookController.colorPalette.alertColor),
          )
        : Container();
  }

  Widget _buttonCraeteBookWidget() {
    CreateBookController createBookController = Provider.of<CreateBookController>(context);
    return Expanded(
      child: ButtonDefaultWidget('Registrar', () {
        createBookController.registerBook();
      }, createBookController.colorPalette.successColor),
    );
  }
}
