import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';

class ListBookPage extends StatefulWidget {
  @override
  _ListBookPageState createState() => _ListBookPageState();
}

class _ListBookPageState extends State<ListBookPage> {
  ColorPalette _colorPalette = new ColorPalette();
  StringText _stringText = new StringText.changeTo(StringText.ENGLISH);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Nome do livro',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    color: _colorPalette.primaryColor,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.pexels.com/photos/2102649/pexels-photo-2102649.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Descrição do livro asda kjhdfkas hdfklasdf ewouysdjkf s fpo soiudyf asdf sdkjfhaeuyw e wefwqyuefiouqweyf  efouief ioqwuyefwef puiqwye',
                          maxLines: 5,
                        ),
                      ),
                      Text(
                        'Total de páginas: 200',
                        textAlign: TextAlign.end,
                      ),
                      Text('Páginas lidas: 64'),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _colorPalette.secondColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    _stringText.borrowed,
                    style: TextStyle(
                      color: _colorPalette.lightColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _colorPalette.secondColor,
        foregroundColor: _colorPalette.lightColor,
        icon: Icon(Icons.add),
        label: Text('Adicionar'),
        onPressed: () {},
      ),
    );
  }
}
