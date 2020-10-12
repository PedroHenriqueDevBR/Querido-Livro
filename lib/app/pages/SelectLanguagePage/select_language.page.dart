import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/repositories/shared_preferences.repository.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';

class SelectLanguagePage extends StatefulWidget {
  @override
  _SelectLanguagePageState createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {

  ColorPalette _colorPalette = ColorPalette();
  String selectedLanguage;
  SharedPreferencesRepository _pref = SharedPreferencesRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          _itemLanguageContainer('assets/images/brasil.jpg', Colors.lightGreen, 'Português', StringText.DEFAULT),
          _itemLanguageContainer('assets/images/usa.jpg', Colors.red, 'English', StringText.ENGLISH),
          _confirmButton(),
        ],
      ),
    );
  }

  Widget _itemLanguageContainer(String image, Color color, String language, String selectLanguage) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          setState(() {
            selectedLanguage = language;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          foregroundDecoration: BoxDecoration(
            color: selectLanguage == selectLanguage ? color : Colors.purple,
            backgroundBlendMode: BlendMode.dst,
          ),
          child: Center(
            child: Text(
              language,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _confirmButton() {
    return Container(
      color: _colorPalette.primaryColor,
      child: ButtonDefaultWidget('Confirmar: ${selectedLanguage != null ? selectedLanguage : ''}', () async {
        await _pref.setLanguage(selectedLanguage);
        Navigator.pop(context);
      }, _colorPalette.primaryColor,),
    );
  }
}
