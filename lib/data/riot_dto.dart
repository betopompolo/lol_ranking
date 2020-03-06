import 'package:lol_ranking/champion.dart';
import 'package:lol_ranking/data/champion_map.dart';

class SummonerDTO {
  int profileIconId;
  String name;
  String puuid;
  int summonerLevel;
  int revisionDate;
  String id;
  String accountId;

  SummonerDTO({
    this.profileIconId, 
    this.name, 
    this.puuid, 
    this.summonerLevel, 
    this.revisionDate, 
    this.id, 
    this.accountId
  });

  factory SummonerDTO.fromJSON(Map<String, dynamic> json) {
    return SummonerDTO(
      profileIconId: json['profileIconId'],
      name: json['name'],
      puuid: json['puuid'],
      summonerLevel: json['summonerLevel'],
      revisionDate: json['revisionDate'],
      id: json['id'],
      accountId: json['accountId']
    );
  }
}

class ChampionDTO {
  String key;
  String name;
  String title;

  ChampionDTO({
    this.key,
    this.name,
    this.title,
  });

  factory ChampionDTO.fromJSON(Map<String, dynamic> json) {
    return ChampionDTO(
      key: json['key'],
      name: json['name'],
      title: json['title'],
    );
  }

  Champion map() {
    String championKey = championNameToKeyMap[this.name];

    return Champion(
      id: this.key,
      name: this.name,
      shortDescription: this.title,
      thumbnailUrl: 'http://ddragon.leagueoflegends.com/cdn/10.4.1/img/champion/$championKey.png'
    );
  }
}

class ChampionMasteryDTO {
  bool chestGranted;
  int championPointsUntilNextLevel;
  int championLevel;

  ChampionMasteryDTO({
    this.chestGranted,
    this.championPointsUntilNextLevel,
    this.championLevel,
  });

  factory ChampionMasteryDTO.fromJSON(Map<String, dynamic> json) {
    return ChampionMasteryDTO(
      chestGranted: json['chestGranted'] ?? false,
      championPointsUntilNextLevel: json['championPointsUntilNextLevel'],
      championLevel: json['championLevel'] ?? 0,
    );
  }

  ChampionMastery map() {
    return ChampionMastery(
      level: this.championLevel,
      pointsToNextLevel: this.championPointsUntilNextLevel,
      isChestAvailable: this.chestGranted,
    );
  }

}