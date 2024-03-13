import 'package:dartz/dartz.dart';
import 'package:template_flutter_asp/app/helpers/errors/errors.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';

class MockUserRepository implements UserRepository {
  List<UserModel> users = [
    UserModel(id: 1, name: 'User 1', isActive: true),
    UserModel(id: 2, name: 'User 2', isActive: false),
    UserModel(id: 3, name: 'User 3', isActive: true),
  ];

  @override
  Future<Either<Failure, UserModel>> update(UserModel model) {
    for (var i = 0; i < users.length; i++) {
      if (users[i].id == model.id) {
        users.removeWhere((element) => element.id == model.id);
        users.insert(i, model);
        return Future.value(right(model));
      }
    }
    return Future.value(left(NoItemsFound(message: '${model.id}')));
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) async {
    users.removeWhere((user) => user.id == id);
    return right(unit);
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAll() async {
    await Future.delayed(const Duration(seconds: 1));
    return right(users);
  }

  @override
  Future<Either<Failure, UserModel>> insert(UserModel model) async {
    users.add(model);
    return Future.value(right(model));
  }
}
