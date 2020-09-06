import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/snackbar_default.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';
import 'package:meu_querido_livro/app/widgets/simple_input.widget.dart';
import 'package:asuka/asuka.dart' as asuka;

class UserRegisterPage extends StatefulWidget {
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtRepeateEmail = TextEditingController();
  ColorPalette _colorPallete = new ColorPalette();
  SnackbarDefault _snackbarDefault = SnackbarDefault();
  IPersonStorage _storage = PersonFirebase();
  StringText _stringText = StringText.changeTo(StringText.ENGLISH);

  Future createUser() async {
    if (validForm()) {
      PersonModel person = PersonModel.create(_txtName.text, '');
      person.email = _txtEmail.text;
      DateTime datetime = DateTime.now();
      String key = '${_txtEmail.text}${datetime.microsecond.toString()}'.replaceAll(' ', '');
      await _storage.createUser(person).then((response) async {
        _showMessage(_stringText.verifyYourEmail);
        _clearFields();
      }).catchError((onError) {
        print(onError);
        _showMessage(_stringText.internalError);
      });
    }
  }

  bool validForm() {
    String name = _txtName.text;
    String email = _txtEmail.text;
    String repeateEmail = _txtRepeateEmail.text;

    if (name.isEmpty || email.isEmpty || repeateEmail.isEmpty) {
      _showMessage(_stringText.fillInTheFields);
      return false;
    } else if (email != repeateEmail) {
      _showMessage(_stringText.differentEmails);
    }
    return true;
  }

  _showMessage(String msg) {
    _globalKey.currentState.showSnackBar(_snackbarDefault.defaultMessage(msg));
  }

  _clearFields() {
    _txtName.text = '';
    _txtEmail.text = '';
    _txtRepeateEmail.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.brown, BlendMode.multiply),
            image: AssetImage('assets/images/splash-imge.jpeg'),
          ),
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Wrap(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        height: 100,
                        image: AssetImage('assets/images/escola.png'),
                      ),
                      SizedBox(height: 16),
                      Text(
                        _stringText.fillInTheFields,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Wrap(
              children: <Widget>[
                Card(
                  color: Color(0XBBFFFFFF),
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _stringText.createUser,
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 32),
                        Column(
                          children: <Widget>[
                            SimpleInputWidget(
                              _txtName,
                              _stringText.name,
                              bordered: true,
                            ),
                            SizedBox(height: 16),
                            SimpleInputWidget(
                              _txtEmail,
                              'E-mail',
                              bordered: true,
                            ),
                            SizedBox(height: 16),
                            SimpleInputWidget(
                              _txtRepeateEmail,
                              _stringText.confirmEmail,
                              bordered: true,
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(_stringText.awaitEmail),
                            ),
                            SizedBox(height: 16),
                            ButtonDefaultWidget(
                              _stringText.register,
                              () {
                                createUser();
                              },
                              _colorPallete.secondColorDark,
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        FlatButton(
                          child: Text(
                            _stringText.goBack,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
