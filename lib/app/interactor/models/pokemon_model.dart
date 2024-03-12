class PokemonModel {
  final int id;
  final String name;
  final String image;

  PokemonModel({required this.id, required this.name, required this.image});

  PokemonModel copyWith({int? id, String? name, String? image}) {
    return PokemonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }
}
