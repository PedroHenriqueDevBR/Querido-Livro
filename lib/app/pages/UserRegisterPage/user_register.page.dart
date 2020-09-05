import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';
import 'package:meu_querido_livro/app/widgets/simple_input.widget.dart';

class UserRegisterPage extends StatefulWidget {
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  TextEditingController _txtNome = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  ColorPalette _colorPallete = new ColorPalette();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: <Widget>[
            Wrap(
              children: <Widget>[
                Padding(
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
                              _txtNome,
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
                              _txtEmail,
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
                              () {},
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
