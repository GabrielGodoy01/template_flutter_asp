import 'package:template_flutter_asp/app/injector.dart';
import 'package:template_flutter_asp/app/interactor/atoms/user_atom.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';

Future<void> fetchTodos() async {
  final repository = injector.get<UserRepository>();
  userState.value = await repository.getAll();
}

Future<void> putTodo(UserModel model) async {
  final repository = injector.get<UserRepository>();

  if (model.id == -1) {
    await repository.insert(model);
  } else {
    await repository.update(model);
  }
  // reload list
  fetchTodos();
}

Future<void> deleteTodo(int id) async {
  final repository = injector.get<UserRepository>();
  await repository.delete(id);
  fetchTodos();
}
