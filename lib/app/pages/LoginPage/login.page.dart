import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/routes.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/snackbar_default.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';
import 'package:meu_querido_livro/app/widgets/simple_input.widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  TextEditingController _txtLogin = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();
  ColorPalette _colorPallete = new ColorPalette();
  IPersonStorage _storage = PersonFirebase();
  SnackbarDefault _snackbarDefault = SnackbarDefault();
  StringText _stringText = StringText.changeTo(StringText.ENGLISH);

  Future loggon() async {
    if (_txtLogin.text.isEmpty) {
      showMessage(_stringText.enterMail);
      return;
    }
    if (_txtPassword.text.isEmpty) {
      showMessage(_stringText.enterPass);
      return;
    }
    await _storage.signin(_txtLogin.text, _txtPassword.text).then((response) {
      Navigator.pushReplacementNamed(context, RouteWidget.HOME_ROUTE);
    }).catchError((error) {
      print(error);
      String errorStr = error.toString();
      if (errorStr.contains('ERROR_INVALID_EMAIL')) {
        showMessage(_stringText.invalidEmail);
      } else if (errorStr.contains('ERROR_USER_NOT_FOUND')) {
        showMessage(_stringText.invalidCredential);
      } else if (errorStr.contains('ERROR_WRONG_PASSWORD')) {
        showMessage(_stringText.invalidCredential);
      } else {
        showMessage(_stringText.internalError);
      }
    });
  }

  void showMessage(String msg) {
    _globalKey.currentState.showSnackBar(_snackbarDefault.defaultMessage(msg));
  }

  @override
  void initState() {
    super.initState();
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.45,
              child: Padding(
                padding: EdgeInsets.all(16),
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
                    Text(
                      _stringText.wantToRegisterMessage,
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              child: Card(
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
                        _stringText.loginPage,
                        style: TextStyle(fontSize: 22),
                      ),
                      Column(
                        children: <Widget>[
                          SimpleInputWidget(
                            _txtLogin,
                            'E-mail',
                            bordered: true,
                          ),
                          SizedBox(height: 16),
                          SimpleInputWidget(
                            _txtPassword,
                            _stringText.password,
                            isPassword: true,
                            bordered: true,
                          ),
                          SizedBox(height: 16),
                          ButtonDefaultWidget(
                            _stringText.enter,
                            () {
                              loggon();
                            },
                            _colorPallete.secondColorDark,
                          ),
                        ],
                      ),
                      FlatButton(
                        child: Text(
                          _stringText.wantToRegister,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteWidget.REGISTER_USER_ROUTE);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
