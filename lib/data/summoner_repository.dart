import 'dart:convert';

import 'package:lol_ranking/summoner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SummonerRepository {
  final String _summonerInfoKey = 'summonerInfoKey';

  Future<Summoner> getSummoner() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final summonerInfo = sharedPreferences.getString(_summonerInfoKey);

    return Summoner.fromJson(json.decode(summonerInfo));
  }

  Future<bool> saveSummoner(Summoner summoner) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.setString(_summonerInfoKey, json.encode(summoner.toJson()));
  }
}