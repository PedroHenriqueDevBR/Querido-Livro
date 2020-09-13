import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/pages/UserConfigurationsPage/user_configurations.controller.dart';
import 'package:meu_querido_livro/app/widgets/button_default.widget.dart';
import 'package:meu_querido_livro/app/widgets/multiline_input.widget.dart';
import 'package:meu_querido_livro/app/widgets/simple_input.widget.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserConfigurationsPage extends StatefulWidget {
  @override
  _UserConfigurationsPageState createState() => _UserConfigurationsPageState();
}

class _UserConfigurationsPageState extends State<UserConfigurationsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserConfigurationsController>(context, listen: false).getLoggedUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserConfigurationsController>(
      builder: (context, userConfigurationsController, child) {
        return ListView(
          children: <Widget>[
            _headerPersonInfoWidget(),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.all(16),
              child: _formUpdateUserDataWidget(),
            ),
          ],
        );
      },
    );
  }

  Widget _headerPersonInfoWidget() {
    UserConfigurationsController userConfigurationsController = Provider.of<UserConfigurationsController>(context);
    return Container(
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
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/livro.png'),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    userConfigurationsController.currentPerson != null ? userConfigurationsController.currentPerson.name : 'Sem nome',
                    style: TextStyle(color: userConfigurationsController.colorPalette.lightColor, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    userConfigurationsController.currentPerson != null ? userConfigurationsController.currentPerson.description : 'Sem descrição',
                    style: TextStyle(color: userConfigurationsController.colorPalette.lightColor, height: 1.6),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _qrCodeCardWidget(),
        ],
      ),
      decoration: BoxDecoration(
        color: userConfigurationsController.colorPalette.secondColor,
        boxShadow: [
          BoxShadow(
            color: userConfigurationsController.colorPalette.primaryColor,
            blurRadius: 8.0,
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(100, 50),
          bottomRight: Radius.elliptical(100, 50),
        ),
      ),
    );
  }

  Widget _formUpdateUserDataWidget() {
    UserConfigurationsController userConfigurationsController = Provider.of<UserConfigurationsController>(context);
    return Column(
      children: <Widget>[
        SimpleInputWidget(
          userConfigurationsController.txtName,
          'Nome completo',
          bordered: true,
        ),
        SizedBox(height: 16),
        MultilineInputWidget(userConfigurationsController.txtDescription, 'Fale mais sobre você'),
        SizedBox(height: 16),
        ButtonDefaultWidget('Registrar', () {
          userConfigurationsController.updateUserData();
        }, userConfigurationsController.colorPalette.primaryColor)
      ],
    );
  }

  /*
   * auxiliary widgets
   */
  Widget _qrCodeCardWidget() {
    UserConfigurationsController userConfigurationsController = Provider.of<UserConfigurationsController>(context);
    return Container(
      decoration: BoxDecoration(
        color: userConfigurationsController.colorPalette.lightColor,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: QrImage(
        data: userConfigurationsController.currentPerson != null ? userConfigurationsController.currentPerson.id != null ? userConfigurationsController.currentPerson.id : '' : '',
        version: QrVersions.auto,
        size: 150.0,
      ),
    );
  }
}
