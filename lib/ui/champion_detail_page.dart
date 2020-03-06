import 'package:flutter/material.dart';
import 'package:lol_ranking/ui/my_scaffold.dart';

class ChampionDetailPage extends StatefulWidget {
  final String championName;

  ChampionDetailPage({this.championName});

  @override
  State<StatefulWidget> createState() {
    return ChampionDetailPageState();
  }
}

class ChampionDetailPageState extends State<ChampionDetailPage> {
  @override
  Widget build(BuildContext context) {
    final _championImgSize = MediaQuery.of(context).size.height * 0.2;
    final name = widget.championName;

    return MyScaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 25, top: 25, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            // Header
            Container(
              width: _championImgSize,
              height: _championImgSize,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://icon2.cleanpng.com/20180326/hgq/kisspng-league-of-legends-ahri-cosplay-wig-nine-tailed-fox-league-of-legends-5ab8d61f1b1033.8352936815220628791109.jpg'),
                  )),
            ),
            SizedBox(height: 22.0),
            Center(
              child: Text(
                name, 
                style: Theme.of(context).textTheme.display4
              ),
            ),
            Center(
              child: Text(
                'A raposa de nove caldas',
                style: Theme.of(context).textTheme.display2,
              ),
            ),
            SizedBox(height: 24.0),
            Divider(
              color: Color(0xffC4C4C4),
              height: 1.0,
            ),
            SizedBox(height: 37.0),
            // Mastery Section
            Text('Nível de maestria', style: Theme.of(context).textTheme.display3),
            SizedBox(height: 16.0),
            Text('4', style: Theme.of(context).textTheme.display4),
            SizedBox(height: 29.0),
            // Available chest Section
            Text('Baús disponíveis', style: Theme.of(context).textTheme.display3),
            SizedBox(height: 16.0),
            Text('2', style: Theme.of(context).textTheme.display4),
          ],
        ),
      ),
    );
  }
}
