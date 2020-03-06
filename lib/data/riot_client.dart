import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lol_ranking/champion.dart';
import 'package:lol_ranking/data/champion_map.dart';
import 'package:lol_ranking/data/riot_dto.dart';
import 'package:lol_ranking/data/summoner_repository.dart';
import 'package:lol_ranking/summoner.dart';

class RiotClient {
  final String _apiKey = 'RGAPI-8bd2abd9-cb8e-4f4c-a30b-f902d22f8f51';
  final String _riotApiBaseUrl = 'https://br1.api.riotgames.com/';

  Future<String> getEncryptedSummonerName(String summonerName) async {
    final String url = _riotApiBaseUrl + '/lol/summoner/v4/summoners/by-name/$summonerName';
    final http.Response response = await http.get(url, 
      headers: _getRiotHeader()
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
      headers: _getRiotHeader(),
    );

    final responseJson = json.decode(response.body);
    final ChampionDTO championDTO = ChampionDTO.fromJSON(responseJson['data'][championKey]);
    return championDTO.map();
  }

  Future<ChampionMastery> getChampionMastery(Champion champion) async {
    final Summoner summoner = await SummonerRepository().getSummoner();
    final String summonerEncryptedName = await this.getEncryptedSummonerName(summoner.name);
    final String summonerUrl = _riotApiBaseUrl + '/lol/champion-mastery/v4/champion-masteries/by-summoner/$summonerEncryptedName/by-champion/${champion.id}';
    final http.Response masteryResponse = await http.get(summonerUrl,
      headers: _getRiotHeader(),
    );
    final masteryResponseJson = json.decode(masteryResponse.body);

    final ChampionMasteryDTO masteryDTO = ChampionMasteryDTO.fromJSON(masteryResponseJson);

    return masteryDTO.map();
  }

  Map<String, String> _getRiotHeader() {
    return {
      'X-Riot-Token': _apiKey
    };
  }
}