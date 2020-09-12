import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/pages/LoginPage/login.controller.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';
import 'package:meu_querido_livro/app/widgets/simple_input.widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Consumer<LoginController>(
      builder: (context, loginController, child) {
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
              _cardLoginInputsWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget _headLoginInfoWidget() {
    LoginController loginController = Provider.of<LoginController>(context);

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
            _textHeadLoginInfoWidget(loginController.textReference.fillInTheFields),
            _textHeadLoginInfoWidget(loginController.textReference.wantToRegisterMessage),
          ],
        ),
      ),
    );
  }

  Widget _cardLoginInputsWidget() {
    LoginController loginController = Provider.of<LoginController>(context);

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
              _textCardLoginInfoWidget(),
              Column(
                children: <Widget>[
                  SimpleInputWidget(
                    loginController.txtLogin,
                    'E-mail',
                    bordered: true,
                  ),
                  SizedBox(height: 16),
                  SimpleInputWidget(
                    loginController.txtPassword,
                    loginController.textReference.password,
                    isPassword: true,
                    bordered: true,
                  ),
                  SizedBox(height: 16),
                  _loginButtonWidget(),
                ],
              ),
              _goToCreateUserPageButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  /* 
  * auxiliary widgets
  */
  Widget _loginButtonWidget() {
    LoginController loginController = Provider.of<LoginController>(context);
    return ButtonDefaultWidget(
      loginController.textReference.enter,
      () {
        loginController.loggon(context);
      },
      loginController.colorPallete.secondColorDark,
    );
  }

  Widget _goToCreateUserPageButtonWidget() {
    LoginController loginController = Provider.of<LoginController>(context);
    return FlatButton(
      child: Text(
        loginController.textReference.wantToRegister,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed: () {
        loginController.goToCreateUserPage(context);
      },
    );
  }

  Text _textHeadLoginInfoWidget(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }

  Text _textCardLoginInfoWidget() {
    LoginController loginController = Provider.of<LoginController>(context);
    return Text(
      loginController.textReference.loginPage,
      style: TextStyle(fontSize: 22),
    );
  }
}
