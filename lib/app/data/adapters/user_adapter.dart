import 'package:template_flutter_asp/app/interactor/models/user_model.dart';

class UserAdapter {
  static Map<String, dynamic> toMap(UserModel user) {
    return {
      'id': user.id,
      'name': user.name,
      'isActive': user.isActive,
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['title'],
      isActive: map['check'],
    );
  }
}
