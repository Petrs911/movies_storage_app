class ActorModel {
  final int id;
  final String name;
  final String originalName;
  final String? profilePath;
  final String character;

  const ActorModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.profilePath,
    required this.character,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
      id: json['id'],
      name: json['name'],
      originalName: json['original_name'],
      profilePath: json['profile_path'],
      character: json['character'],
    );
  }
}
