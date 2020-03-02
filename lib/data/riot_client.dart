import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lol_ranking/champion.dart';
import 'package:lol_ranking/data/champion_map.dart';
import 'package:lol_ranking/data/riot_dto.dart';

class RiotClient {
  final String _apiKey = 'RGAPI-e36f53b5-64be-467a-9b3c-f5aa551db00b';

  Future<String> getEncryptedSummonerName(String summonerName) async {
    final String url = 'https://br1.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName';
    final http.Response response = await http.get(url, 
      headers: <String, String> {
        'X-Riot-Token': _apiKey
      }
    );

    SummonerDTO summonerDTO = SummonerDTO.fromJSON(json.decode(response.body));
    String encryptedSummonerName = summonerDTO.id;

    return encryptedSummonerName;
  }

  List<String> searchChampionName(String query) {
    if (query == null || query.isEmpty) {
      return [];
    }

    String formattedQuery = query[0].toUpperCase() + query.substring(1);
    List<String> searchResults = championNameToKeyMap.keys.where((key) => key.startsWith(formattedQuery)).toList();

    return searchResults ?? [];
  }

  Future<Champion> getChampionByName(String name) async {
    final String championKey = championNameToKeyMap[name];
    if (championKey == null || championKey.isEmpty) {
      return null;
    }

    final String url = 'http://ddragon.leagueoflegends.com/cdn/10.4.1/data/pt_BR/champion/$championKey.json';
    final http.Response response = await http.get(url, 
      headers: <String, String> {
        'X-Riot-Token': _apiKey
      }
    );

    final responseJson = json.decode(response.body);

    ChampionDTO championDTO = ChampionDTO.fromJSON(responseJson['data'][championKey]);

    return championDTO.map();
  }
}