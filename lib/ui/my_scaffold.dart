import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final Widget appBar;

  MyScaffold({ 
    this.appBar,
    this.body, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.appBar ?? MyAppBar(),
      body: this.body,
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  MyAppBar({ 
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      iconTheme: IconThemeData(color: Colors.white),
      title: Text('$title', style: TextStyle(color: Color(0xffC4C4C4))),
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
