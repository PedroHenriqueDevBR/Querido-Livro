import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ColorPalette _colorPalette = new ColorPalette();
  StringText _stringText = new StringText.changeTo(StringText.DEFAULT);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      children: <Widget>[
        _cardDashboard(),
        SizedBox(height: 16),
        _cardBorrowed(),
        SizedBox(height: 16),
        _cardReceived(),
      ],
    );
  }

  Card _cardDashboard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: _colorPalette.secondColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                _stringText.dashboard,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: _colorPalette.lightColor),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                _lineInfo(_stringText.registered, '5'),
                Divider(),
                _lineInfo(_stringText.reading, '1'),
                Divider(),
                _lineInfo(_stringText.borrowed, '2'),
                Divider(),
                _lineInfo(_stringText.received, '1'),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card _cardBorrowed() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: _colorPalette.secondColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                _stringText.borrowedBook,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: _colorPalette.lightColor),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                _lineInfo('Código limpo', '22-02-2020'),
                Divider(),
                _lineInfo('O Monge e o executivo', '25-08-2020'),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card _cardReceived() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: _colorPalette.secondColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                _stringText.receivedBook,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: _colorPalette.lightColor),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                _lineInfo('Código limpo', '22-02-2020'),
                Divider(),
                _lineInfo('O Monge e o executivo', '25-08-2020'),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _lineInfo(String title, String value) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        )),
        Text(
          value,
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }
}
