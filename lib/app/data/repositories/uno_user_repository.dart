import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:template_flutter_asp/app/data/adapters/user_adapter.dart';
import 'package:template_flutter_asp/app/helpers/enums/http_status_code_enum.dart';
import 'package:template_flutter_asp/app/helpers/errors/errors.dart';
import 'package:template_flutter_asp/app/helpers/functions/get_http_status_function.dart';
import 'package:template_flutter_asp/app/injector.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';
import 'package:template_flutter_asp/app/helpers/services/http_service.dart';
import 'package:uno/uno.dart';

class UnoUserRepository implements UserRepository {
  final _httpService = injector.get<HttpService>();

  UnoUserRepository();

  @override
  Future<Either<Failure, Unit>> delete(int id) async {
    try {
      Response response = await _httpService.delete('/user/$id');
      if (response.status == 200) {
        return right(unit);
      }
      throw Exception();
    } on UnoError catch (e) {
      HttpStatusCodeEnum errorType =
          getHttpStatusFunction(e.response?.status ?? HttpStatus.badRequest);
      return left(ErrorRequest(message: errorType.errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAll() async {
    try {
      return await _httpService.get('/user').then((response) {
        if (response.status == 200) {
          var users = response.data.map((e) => UserAdapter.fromMap(e)).toList();
          return right(users);
        }
        throw Exception();
      });
    } on UnoError catch (e) {
      HttpStatusCodeEnum errorType =
          getHttpStatusFunction(e.response?.status ?? HttpStatus.badRequest);
      return left(ErrorRequest(message: errorType.errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserModel>> insert(UserModel model) async {
    try {
      return await _httpService
          .post('/user', data: UserAdapter.toMap(model))
          .then((response) {
        if (response.status == 201) {
          var data = response.data;
          var user = UserAdapter.fromMap(data);
          return right(user);
        }
        throw Exception();
      });
    } on UnoError catch (e) {
      HttpStatusCodeEnum errorType =
          getHttpStatusFunction(e.response?.status ?? HttpStatus.badRequest);
      return left(ErrorRequest(message: errorType.errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserModel>> update(UserModel model) async {
    try {
      return await _httpService
          .put('/user/${model.id}', data: UserAdapter.toMap(model))
          .then((response) {
        if (response.status == 200) {
          var data = response.data;
          var user = UserAdapter.fromMap(data);
          return right(user);
        }
        throw Exception();
      });
    } on UnoError catch (e) {
      HttpStatusCodeEnum errorType =
          getHttpStatusFunction(e.response?.status ?? HttpStatus.badRequest);
      return left(ErrorRequest(message: errorType.errorMessage));
    }
  }
}
