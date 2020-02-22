class Summoner {
  String name;
  int level;

  Summoner({
    this.name,
    this.level,
  });

  factory Summoner.fromJson(Map<String, dynamic> json) {
    return Summoner(
      name: json['name'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': this.name,
    'level': this.level,
  };
}