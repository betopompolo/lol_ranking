import 'package:flutter/material.dart';
import 'package:lol_ranking/champion.dart';
import 'package:lol_ranking/data/riot_client.dart';
import 'package:lol_ranking/ui/my_scaffold.dart';

class ChampionDetailPage extends StatefulWidget {
  final String championName;

  ChampionDetailPage({this.championName});

  @override
  State<StatefulWidget> createState() => ChampionDetailPageState();
}

class ChampionDetailPageState extends State<ChampionDetailPage> {
  Future<Champion> _futureChampion;
  Future<ChampionMastery> _futureMastery;
  final RiotClient _riotClient = RiotClient();

  @override
  void initState() {
    super.initState();
    _futureChampion = _riotClient.getChampionByName(widget.championName);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: FutureBuilder(
        future: _futureChampion,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Champion champion = snapshot.data;

            if (_futureMastery == null) {
              _futureMastery = _riotClient.getChampionMastery(champion);
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 25, top: 25, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  ..._buildHeader(champion),
                  _buildChampionInfo(champion),
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
      )
    );
  }

  List<Widget> _buildHeader(Champion champion) {
    final _championImgSize = MediaQuery.of(context).size.height * 0.2;

    return [
      Container(
        width: _championImgSize,
        height: _championImgSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(champion.thumbnailUrl),
          )
        ),
      ),
      SizedBox(height: 22.0),
      Center(
        child: Text(champion.name, style: Theme.of(context).textTheme.display4),
      ),
      Center(
        child: Text(
          champion.shortDescription[0].toUpperCase() + champion.shortDescription.substring(1),
          style: Theme.of(context).textTheme.display2,
        ),
      ),
      SizedBox(height: 24.0),
      Divider(
        color: Color(0xffC4C4C4),
        height: 1.0,
      ),
      SizedBox(height: 37.0),
    ];
  }

  Widget _buildChampionInfo(Champion champion) {
    return FutureBuilder(
      future: _futureMastery,
      builder: (context, snapshot) {
        ChampionMastery mastery = snapshot.data;
        
        if (snapshot.hasData) {
          String availableChests = mastery.isChestAvailable ? '1' : '0';
          String masteryLevel = mastery.level == null ? '' : mastery.level.toString();

          return Column(
            children: <Widget>[
              ..._buildSection(
                title: 'Nível de maestria',
                data: masteryLevel,
              ),
              ..._buildSection(
                title: 'Baús Disponíveis',
                data: availableChests,
                hasBottomPadding: false,
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  List<Widget> _buildSection({String title, String data, bool hasBottomPadding = true}) {
    List<Widget> sectionWidgets = <Widget>[
      Text(
        title,
        style: Theme.of(context).textTheme.display3
      ),
      SizedBox(height: 16.0),
      Text(data, style: Theme.of(context).textTheme.display4),
    ];

    if (hasBottomPadding) {
      sectionWidgets.add(SizedBox(height: 29.0));
    }

    return sectionWidgets;
  }
}
