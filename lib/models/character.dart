class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final List<String> episodeUrls;
  final String url;
  final String created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.episodeUrls,
    required this.url,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
      episodeUrls: List<String>.from(json['episode']),
      url: json['url'],
      created: json['created'],
    );
  }
}