import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';
import 'package:meu_querido_livro/app/widgets/multiline_input.widget.dart';
import 'package:meu_querido_livro/app/widgets/simple_input.widget.dart';

class CreateBookPage extends StatefulWidget {
  @override
  _CreateBookPageState createState() => _CreateBookPageState();
}

class _CreateBookPageState extends State<CreateBookPage> {
  StringText _stringText = StringText.changeTo(StringText.ENGLISH);
  ColorPalette _colorPalette = ColorPalette();

  TextEditingController _txtName;
  TextEditingController _txtDescription;
  TextEditingController _txtBookPageCount;
  TextEditingController _txtReadPageCount;
  TextEditingController _txtBorrowedReadPageCount;
  String pictureUrl;
  bool enable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      _txtBookPageCount,
                      'Número de páginas',
                      bordered: true,
                    )),
                    SizedBox(width: 16),
                    Expanded(
                        child: SimpleInputWidget(
                      _txtReadPageCount,
                      'Páginas lidas',
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
                ButtonDefaultWidget('Registrar', () {}, _colorPalette.secondColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
