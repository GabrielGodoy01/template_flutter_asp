import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';

class MockUserRepository implements UserRepository {
  List<UserModel> users = [
    UserModel(id: 1, name: 'User 1', isActive: true),
    UserModel(id: 2, name: 'User 2', isActive: false),
    UserModel(id: 3, name: 'User 3', isActive: true),
  ];

  @override
  Future<bool> delete(int id) async {
    users.removeWhere((element) => element.id == id);
    return true;
  }

  @override
  Future<List<UserModel>> getAll() async {
    return users;
  }

  @override
  Future<UserModel> insert(UserModel model) async {
    users.add(model);
    return Future.value(model);
  }

  @override
  Future<UserModel> update(UserModel model) async {
    users.removeWhere((element) => element.id == model.id);
    users.add(model);
    return model;
  }
}
