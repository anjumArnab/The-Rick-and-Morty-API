class Episode {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characterUrls;
  final String url;
  final String created;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characterUrls,
    required this.url,
    required this.created,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episode: json['episode'],
      characterUrls: List<String>.from(json['characters']),
      url: json['url'],
      created: json['created'],
    );
  }
}