import 'package:flutter_test/flutter_test.dart';
import 'package:lol_ranking/champion.dart';
import 'package:lol_ranking/data/riot_client.dart';

void main() {
  group("Riot Client Tests", () {
    RiotClient client = RiotClient();
    test('Should get the encrypted summoner name', () async {
      String summonerName = 'FabricioSRF';
      String encryptedSummonerName = await client.getEncryptedSummonerName(summonerName);

      expect(encryptedSummonerName, isNotEmpty);
    });

    test('Should search champion name correctly', () {
      List<String> results = client.searchChampionName('wu');
      
      expect(results, hasLength(1));
      expect(results, contains('Wukong'));
    });

    test('Should get champion info (Wukong) correctly', () async {
      Champion champion = await client.getChampionByName('Wukong');
      
      expect(champion.name, equals('Wukong'));
    });
  });
}
