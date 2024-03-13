import 'package:template_flutter_asp/app/injector.dart';
import 'package:template_flutter_asp/app/interactor/atoms/user_atom.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';
import 'package:template_flutter_asp/app/interactor/states/edit_user_state.dart';
import 'package:template_flutter_asp/app/interactor/states/user_state.dart';

Future<void> fetchUsers() async {
  final repository = injector.get<UserRepository>();
  userState.value = const LoadingUserState();
  var result = await repository.getAll();
  result.fold(
    (error) => userState.value = FailureUserState(error.message),
    (data) => userState.value = GettedUserState(data),
  );
}

Future<void> updateUser(UserModel model) async {
  final repository = injector.get<UserRepository>();
  editUserState.value = const LoadingEditUserState();
  await repository.update(model).then((value) {
    value.fold(
      (error) => editUserState.value = FailureEditUserState(error.message),
      (data) => editUserState.value = const SavedUserState(),
    );
  });
  await fetchUsers();
}

Future<void> insertUser(UserModel model) async {
  final repository = injector.get<UserRepository>();
  editUserState.value = const LoadingEditUserState();
  await repository.insert(model).then((value) {
    value.fold(
      (error) => editUserState.value = FailureEditUserState(error.message),
      (data) => editUserState.value = const SavedUserState(),
    );
  });
  await fetchUsers();
}

Future<void> deleteUser(int id) async {
  final repository = injector.get<UserRepository>();
  editUserState.value = const LoadingEditUserState();
  await repository.delete(id).then((value) {
    value.fold(
      (error) => editUserState.value = FailureEditUserState(error.message),
      (data) => editUserState.value = const SavedUserState(),
    );
  });
  await fetchUsers();
}
