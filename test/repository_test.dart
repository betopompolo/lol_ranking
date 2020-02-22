import 'package:flutter_test/flutter_test.dart';
import 'package:lol_ranking/data/summoner_repository.dart';
import 'package:lol_ranking/summoner.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group("Repository tests", () {
    // Since SummonerRepository uses SharedPreferences, its necessary to initialize SharedPreferences here.
    SharedPreferences.setMockInitialValues({});
    test('Should save and retrieve the summoner info properly', () async {
      Summoner testSummoner = Summoner(
        level: 52,
        name: 'FabricioSRF'
      );
      SummonerRepository summonerRepository = SummonerRepository();

      await summonerRepository.saveSummoner(testSummoner);
      
      Summoner savedSummoner = await summonerRepository.getSummoner();

      expect(savedSummoner, isNotNull);
      expect(savedSummoner.level, testSummoner.level);
      expect(savedSummoner.name, testSummoner.name);
    });
  });
}
