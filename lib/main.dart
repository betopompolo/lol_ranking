import 'package:flutter/material.dart';
import 'package:lol_ranking/ui/search_page.dart';
import 'package:lol_ranking/ui/typography.dart';

void main() => runApp(MyApp());

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff0BC6E3),
        backgroundColor: Color(0xff081A21),
        textTheme: myTextTheme,
        fontFamily: myFontFamily,
      ),
      home: SearchPage(),
      navigatorObservers: [routeObserver],
    );
  }
}
