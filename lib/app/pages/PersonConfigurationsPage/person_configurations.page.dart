import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';
import 'package:meu_querido_livro/app/widgets/multiline_input.widget.dart';
import 'package:meu_querido_livro/app/widgets/simple_input.widget.dart';

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
          color: _colorPalette.secondColor,
          padding: EdgeInsets.all(32),
          child: Row(
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
        ),
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
