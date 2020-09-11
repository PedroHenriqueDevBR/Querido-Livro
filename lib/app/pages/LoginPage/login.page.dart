import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/pages/LoginPage/login.controller.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/routes.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/snackbar_default.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';
import 'package:meu_querido_livro/app/widgets/simple_input.widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  StringText _stringText = StringText.changeTo(StringText.ENGLISH);
  ColorPalette _colorPallete = new ColorPalette();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Consumer<LoginController>(
      builder: (context, model, child) {
        return Container(
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
              _headLoginInfoWidget(),
              _cardLoginInputsWidget(model),
            ],
          ),
        );
      },
    );
  }

  Widget _headLoginInfoWidget() {
    return Container(
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
            _textHeadLoginInfo(_stringText.fillInTheFields),
            _textHeadLoginInfo(_stringText.wantToRegisterMessage),
          ],
        ),
      ),
    );
  }

  Widget _cardLoginInputsWidget(LoginController model) {
    return Container(
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
              _cardLoginInfo(),
              Column(
                children: <Widget>[
                  SimpleInputWidget(
                    model.txtLogin,
                    'E-mail',
                    bordered: true,
                  ),
                  SizedBox(height: 16),
                  SimpleInputWidget(
                    model.txtPassword,
                    _stringText.password,
                    isPassword: true,
                    bordered: true,
                  ),
                  SizedBox(height: 16),
                  _loginButton(model),
                ],
              ),
              _goToCreateUserPageButton(model),
            ],
          ),
        ),
      ),
    );
  }

  /* 
  * auxiliary methods/widgets
  */
  Widget _loginButton(LoginController model) {
    return ButtonDefaultWidget(
      _stringText.enter,
      () {
        model.loggon(context);
      },
      _colorPallete.secondColorDark,
    );
  }

  Widget _goToCreateUserPageButton(LoginController model) {
    return FlatButton(
      child: Text(
        _stringText.wantToRegister,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed: () {
        model.goToCreateUserPage(context);
      },
    );
  }

  Text _textHeadLoginInfo(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }

  Text _cardLoginInfo() {
    return Text(
      _stringText.loginPage,
      style: TextStyle(fontSize: 22),
    );
  }
}
