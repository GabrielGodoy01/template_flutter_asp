import 'package:dartz/dartz.dart';
import 'package:template_flutter_asp/app/helpers/errors/errors.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserModel>>> getAll();

  Future<Either<Failure, UserModel>> insert(UserModel model);

  Future<Either<Failure, UserModel>> update(UserModel model);

  Future<Either<Failure, Unit>> delete(int id);
}
