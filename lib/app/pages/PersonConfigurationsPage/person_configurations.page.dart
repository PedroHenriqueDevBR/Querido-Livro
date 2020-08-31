import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';
import 'package:meu_querido_livro/app/widgets/multiline_input.widget.dart';
import 'package:meu_querido_livro/app/widgets/simple_input.widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PersonConfigurationsPage extends StatefulWidget {
  @override
  _PersonConfigurationsPageState createState() => _PersonConfigurationsPageState();
}

class _PersonConfigurationsPageState extends State<PersonConfigurationsPage> {
  ColorPalette _colorPalette = new ColorPalette();
  StringText _stringText = new StringText.changeTo(StringText.ENGLISH);

  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 75,
                    height: 75,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('https://avatars3.githubusercontent.com/u/36716898?s=460&u=9eb41db9519084bad7af7bd46d544d7b0be67eea&v=4'),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Nome da pessoa',
                        style: TextStyle(color: _colorPalette.lightColor, fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        'Descrição da pessoa ldopsduf aspodif asopidf uapsoidf sadlkfjh aosidyuasdwuieyf wef oiasudfopiuweof asdf a0euw 0fue',
                        style: TextStyle(color: _colorPalette.lightColor, height: 1.6),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: _colorPalette.lightColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: QrImage(
                  data: "1234567890",
                  version: QrVersions.auto,
                  size: 150.0,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: _colorPalette.secondColor,
            boxShadow: [
              BoxShadow(
                color: _colorPalette.primaryColor,
                blurRadius: 8.0,
              )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(100, 50),
              bottomRight: Radius.elliptical(100, 50),
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              SimpleInputWidget(
                _txtName,
                'Nome completo',
                bordered: true,
              ),
              SizedBox(height: 16),
              MultilineInputWidget(_txtDescription, 'Fale mais sobre você'),
              SizedBox(height: 16),
              ButtonDefaultWidget('Registrar', () {}, _colorPalette.primaryColor)
            ],
          ),
        ),
      ],
    );
  }
}
