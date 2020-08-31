import 'package:flutter/material.dart';

class PersonConfigurationsPage extends StatefulWidget {
  @override
  _PersonConfigurationsPageState createState() => _PersonConfigurationsPageState();
}

class _PersonConfigurationsPageState extends State<PersonConfigurationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações do usuário'),
      ),
    );
  }
}
