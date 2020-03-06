import 'package:flutter/material.dart';
import 'package:lol_ranking/data/riot_client.dart';
import 'package:lol_ranking/data/summoner_repository.dart';
import 'package:lol_ranking/main.dart';
import 'package:lol_ranking/summoner.dart';
import 'package:lol_ranking/ui/champion_detail_page.dart';
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
          _openLoginPage();
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
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('$title', style: TextStyle(color: Color(0xffC4C4C4))),
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 25, top: 25, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SearchForm(
              onSubmit: _handleSearchSubmit,
            )
          ],
        ),
      ),
    );
  }

  _handleSearchSubmit(String championName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChampionDetailPage(championName: championName)));
  }

  _openLoginPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
          fullscreenDialog: true,
        ));
  }
}

class SearchForm extends StatefulWidget {
  final Function(String) onSubmit;

  SearchForm({this.onSubmit});

  @override
  State<StatefulWidget> createState() => SearchFormState();
}

class SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  final RiotClient _riotClient = RiotClient();
  List<String> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = [];
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: textDecoration.copyWith(
                hintText: 'Nome do campeão',
                prefixIcon: Icon(Icons.search, color: Color(0xffC4C4C4)),
              ),
              validator: (value) =>
                  value.isEmpty ? 'Digite o nome do campeão' : null,
              style: textStyle,
              onChanged: _handleSearchChange,
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.separated(
                itemCount: _searchResults.length,
                itemBuilder: _buildItem,
                separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(context, index) {
    final championName = _searchResults[index];

    return ListTile(
      onTap: () => this.widget.onSubmit(championName),
      title: Text(championName, style: textStyle),
    );
  }

  _handleSearchChange(String input) {
    setState(() {
      _searchResults = _riotClient.searchChampionName(input);
    });
  }
}
