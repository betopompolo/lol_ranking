class Champion {
  String id;
  String name;
  String shortDescription;
  String thumbnailUrl;

  Champion({
    this.id,
    this.name,
    this.shortDescription,
    this.thumbnailUrl,
  });
}

class ChampionMastery {
  int level;
  int pointsToNextLevel;
  bool isChestAvailable;

  ChampionMastery({
    this.level,
    this.pointsToNextLevel,
    this.isChestAvailable,
  });
}