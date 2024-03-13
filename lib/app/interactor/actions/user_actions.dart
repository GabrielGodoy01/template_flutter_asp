import 'package:template_flutter_asp/app/helpers/functions/global_snackbar.dart';
import 'package:template_flutter_asp/app/injector.dart';
import 'package:template_flutter_asp/app/interactor/atoms/user_atom.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';

Future<void> fetchUsers() async {
  final repository = injector.get<UserRepository>();
  userLoading.value = true;
  userOnError.value = false;
  var result = await repository.getAll();
  result.fold(
    (error) {
      userOnError.value = true;
      GlobalSnackBar.error(error.message);
    },
    (data) => userState.value = data,
  );
  userLoading.value = false;
}

Future<void> updateUser(UserModel model) async {
  final repository = injector.get<UserRepository>();
  await repository.update(model).then((value) {
    value.fold(
      (error) => GlobalSnackBar.error(error.message),
      (data) => GlobalSnackBar.success('User updated'),
    );
  });
  await fetchUsers();
}

Future<void> insertUser(UserModel model) async {
  final repository = injector.get<UserRepository>();
  await repository.insert(model).then((value) {
    value.fold(
      (error) => GlobalSnackBar.error(error.message),
      (data) => GlobalSnackBar.success('User inserted'),
    );
  });
  await fetchUsers();
}

Future<void> deleteUser(int id) async {
  final repository = injector.get<UserRepository>();
  await repository.delete(id).then((value) {
    value.fold(
      (error) => GlobalSnackBar.error(error.message),
      (data) => GlobalSnackBar.success('User deleted'),
    );
  });
  await fetchUsers();
}
