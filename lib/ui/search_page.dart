import 'package:flutter/material.dart';
import 'package:lol_ranking/data/summoner_repository.dart';
import 'package:lol_ranking/main.dart';
import 'package:lol_ranking/summoner.dart';
import 'package:lol_ranking/ui/form_style.dart';
import 'package:lol_ranking/ui/login_page.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> with RouteAware {
  String title = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    if (title.isEmpty) {
      SummonerRepository().getSummoner().then((Summoner summoner) {
        if (summoner == null) {
          _navigateToLoginPage();
        } else {
          setState(() {
            title = summoner.name;
          });
        }
      });
    }
    super.didPush();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('$title', style: TextStyle(color: Colors.white))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[SearchForm()],
        ),
      ),
    );
  }

  void _navigateToLoginPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
          fullscreenDialog: true,
        ));
  }
}

class SearchForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchFormState();
}

class SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  final _championNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              decoration: textDecoration.copyWith(
                  hintText: 'Nome do campeão', suffixIcon: Icon(Icons.search)),
              validator: (value) =>
                  value.isEmpty ? 'Digite o nome do campeão' : null,
              style: textStyle,
              controller: _championNameTextController,
            ),
            flex: 6,
          ),
          SizedBox(width: 10.0)
        ],
      ),
    );
  }
}
