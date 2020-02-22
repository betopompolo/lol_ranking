import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lol_ranking/ui/search_page.dart';

void main() => runApp(MyApp());

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff0BC6E3),
        brightness: Brightness.dark,
        textTheme:
            TextTheme(display4: TextStyle(fontSize: 72.0, color: Colors.white)),
        fontFamily: 'Montserrat',
      ),
      home: SearchPage(),
      navigatorObservers: [routeObserver],
    );
  }
}
