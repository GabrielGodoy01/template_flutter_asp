import 'package:flutter_test/flutter_test.dart';
import 'package:template_flutter_asp/app/data/mock_user_repository.dart';
import 'package:template_flutter_asp/app/injector.dart';
import 'package:template_flutter_asp/app/interactor/actions/user_actions.dart';
import 'package:template_flutter_asp/app/interactor/atoms/user_atom.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';

void main() {
  late MockUserRepository mockRepository;

  setUpAll(() {
    mockRepository = MockUserRepository();
    injector.add<UserRepository>(() => mockRepository);
  });

  group('fetchUsers', () {
    test('should fetch users from repository and update userState', () async {
      await fetchUsers();

      expect(listUsersState.value, equals(mockRepository.users));
    });
  });

  group('updateUser', () {
    test('should insert a new user', () async {
      final newUser = UserModel(id: 5, name: 'Jane', isActive: true);

      await updateUser(newUser);

      expect(listUsersState.value, contains(newUser));
    });
  });

  group('insertUser', () {
    test('should insert new user into repository and fetch', () async {
      final newUser = UserModel(id: 4, name: 'Jane', isActive: true);

      await insertUser(newUser);

      expect(listUsersState.value, contains(newUser));
    });
  });

  group('deleteUser', () {
    test('should delete user from repository and fetch', () async {
      const todoId = 1;

      await deleteUser(todoId);

      expect(listUsersState.value.length, equals(4));
    });
  });
}