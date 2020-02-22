import 'package:flutter/material.dart';
import 'package:lol_ranking/ui/form_style.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Digite o seu nome de invocador para acessar o app',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 20.0),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _formChildSpace = 20.0;
  final _summonerNameFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: _formChildSpace),
              TextFormField(
                validator: (value) => value.isEmpty ? 'Digite seu nome de invocador' : null,
                decoration: textDecoration.copyWith(hintText: 'Nome de invocador'),
                style: textStyle,
                controller: _summonerNameFieldController,
              ),
              SizedBox(height: _formChildSpace * 1.2),
              RaisedButton(
                onPressed: _handleSubmit,
                child: Text('Entrar'),
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ));
  }

  void _handleSubmit() {
    if (_formKey.currentState.validate()) {
      String summonerName = _summonerNameFieldController.text;
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('$summonerName'))); 
    }
  }
}
