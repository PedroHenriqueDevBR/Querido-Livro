import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/pages/UserRegisterPage/user_register.controlelr.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';
import 'package:meu_querido_livro/app/widgets/simple_input.widget.dart';
import 'package:provider/provider.dart';

class UserRegisterPage extends StatefulWidget {
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Consumer<UserRegisterController>(
      builder: (context, userRegisterController, child) {
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
              _headPageInfoWidget(),
              _formContainerWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget _headPageInfoWidget() {
    UserRegisterController userRegisterController = Provider.of<UserRegisterController>(context);

    return Wrap(
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
                userRegisterController.textReference.fillInTheFields,
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
    );
  }

  Widget _formContainerWidget() {
    UserRegisterController userRegisterController = Provider.of<UserRegisterController>(context);
    return Wrap(
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
                  userRegisterController.textReference.createUser,
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 32),
                _listFormInputsWidget(),
                SizedBox(height: 32),
                _goBackButtonWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // auxilliary widgets

  Widget _listFormInputsWidget() {
    UserRegisterController userRegisterController = Provider.of<UserRegisterController>(context);
    return Column(
      children: <Widget>[
        SimpleInputWidget(
          userRegisterController.txtName,
          userRegisterController.textReference.name,
          bordered: true,
        ),
        SizedBox(height: 16),
        SimpleInputWidget(
          userRegisterController.txtEmail,
          'E-mail',
          bordered: true,
        ),
        SizedBox(height: 16),
        SimpleInputWidget(
          userRegisterController.txtRepeateEmail,
          userRegisterController.textReference.confirmEmail,
          bordered: true,
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(userRegisterController.textReference.awaitEmail),
        ),
        SizedBox(height: 16),
        _registerDataButtonWidget(),
      ],
    );
  }

  _registerDataButtonWidget() {
    UserRegisterController userRegisterController = Provider.of<UserRegisterController>(context);
    return ButtonDefaultWidget(
      userRegisterController.textReference.register,
      () {
        userRegisterController.createUser();
      },
      userRegisterController.colorPallete.secondColorDark,
    );
  }

  _goBackButtonWidget() {
    UserRegisterController userRegisterController = Provider.of<UserRegisterController>(context);
    return FlatButton(
      child: Text(
        userRegisterController.textReference.goBack,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
