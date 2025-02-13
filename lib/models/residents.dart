class ResidentModel {
  final String name;
  final String imageUrl;

  ResidentModel({required this.name, required this.imageUrl});

  factory ResidentModel.fromJson(Map<String, dynamic> json) {
    return ResidentModel(
      name: json['name'],
      imageUrl: json['image'],
    );
  }
}
