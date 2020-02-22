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
              'Faça login com sua conta Riot para acessar o app',
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
  final _key = GlobalKey<FormState>();
  final _formChildSpace = 20.0;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: _formChildSpace),
              TextFormField(
                validator: (value) => value.isEmpty ? 'Digite seu usuário' : null,
                decoration: textDecoration.copyWith(hintText: 'Usuário'),
                style: textStyle,
              ),
              SizedBox(height: _formChildSpace),
              TextFormField(
                validator: (value) => value.isEmpty ? 'Digite sua senha' : null,
                obscureText: true,
                decoration: textDecoration.copyWith(hintText: 'Senha'),
                style: textStyle,
              ),
              SizedBox(height: _formChildSpace * 1.2),
              RaisedButton(
                onPressed: () {
                  if (_key.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Form válido :)'),
                    ));
                  }
                },
                child: Text('Entrar'),
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ));
  }
}
