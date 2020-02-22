import 'package:flutter/material.dart';
import 'package:lol_ranking/ui/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff0BC6E3),
        brightness: Brightness.dark,
        textTheme: TextTheme(
          display4: TextStyle(fontSize: 72.0, color: Colors.white)
        ),
        fontFamily: 'Montserrat',
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff081A21),
      body: LoginPage(),
    );
  }
}
