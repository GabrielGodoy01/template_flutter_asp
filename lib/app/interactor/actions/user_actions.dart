import 'package:template_flutter_asp/app/injector.dart';
import 'package:template_flutter_asp/app/interactor/atoms/user_atom.dart';
import 'package:template_flutter_asp/app/interactor/models/state_model.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';

Future<void> fetchUsers() async {
  final repository = injector.get<UserRepository>();
  setUserState(LoadingState());
  var result = await repository.getAll();
  result.fold(
    (l) => setUserState(ErrorState(errorMessage: l.message)),
    (r) {
      listUsersState.value = r;
      setUserState(SuccessState());
    },
  );
}

Future<void> updateUser(UserModel model) async {
  final repository = injector.get<UserRepository>();
  await repository.update(model);
  await fetchUsers();
}

Future<void> insertUser(UserModel model) async {
  final repository = injector.get<UserRepository>();
  await repository.insert(model);
  await fetchUsers();
}

Future<void> deleteUser(int id) async {
  final repository = injector.get<UserRepository>();
  await repository.delete(id);
  await fetchUsers();
}

void setUserState(State state) {
  userState.value = state;
}
