class UserModel {
  final int id;
  final String name;
  final bool isActive;

  UserModel({required this.id, required this.name, required this.isActive});

  UserModel copyWith({int? id, String? name, bool? isActive}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }
}
