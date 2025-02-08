class Location {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residentsUrls;
  final String url;
  final String created;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residentsUrls,
    required this.url,
    required this.created,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      dimension: json['dimension'],
      residentsUrls: List<String>.from(json['residents']),
      url: json['url'],
      created: json['created'],
    );
  }
}