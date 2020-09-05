import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/snackbar_default.dart';
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

  Future createUser() async {
    if (validForm()) {
      PersonModel person = PersonModel.create(_txtName.text, '');
      person.email = _txtEmail.text;
      person.password = '123456';
      await _storage.createUser(person).then((response) async {
        _showMessage('Verifique a sua caixa de e-mail para finalizar o seu cadastro');
        _clearFields();
      }).catchError((onError) {
        print(onError);
        _showMessage('Ocorreu um erro ao cadastrar o dados');
      });
    }
  }

  bool validForm() {
    String name = _txtName.text;
    String email = _txtEmail.text;
    String repeateEmail = _txtRepeateEmail.text;

    if (name.isEmpty || email.isEmpty || repeateEmail.isEmpty) {
      _showMessage('Atenção: Preencha todos os campos');
      return false;
    } else if (email != repeateEmail) {
      _showMessage('Atenção: Os e-mails digitados são diferentes');
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
            image: NetworkImage('https://images.pexels.com/photos/698928/pexels-photo-698928.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
          ),
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Wrap(
              children: <Widget>[
                Padding(
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
                        'Preencha todos os campos para cadastrar um usuário',
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
                          'Cadastro de usuário',
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 32),
                        Column(
                          children: <Widget>[
                            SimpleInputWidget(
                              _txtName,
                              'Nome completo',
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
                              'Confirmar e-mail',
                              bordered: true,
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('Será enviado um e-mail solicito a definição da sua senha.\nApós o cadastro aguarde o email chegar na sua caixa de recebimento'),
                            ),
                            SizedBox(height: 16),
                            ButtonDefaultWidget(
                              'Registrar',
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
                            'Voltar',
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
