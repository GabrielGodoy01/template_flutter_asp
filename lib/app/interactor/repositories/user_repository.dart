import 'package:template_flutter_asp/app/interactor/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getAll();

  Future<UserModel> insert(UserModel model);

  Future<UserModel> update(UserModel model);

  Future<bool> delete(int id);
}
