import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template_flutter_asp/app/data/repositories/mock_user_repository.dart';
import 'package:template_flutter_asp/app/injector.dart';
import 'package:template_flutter_asp/app/interactor/actions/user_actions.dart';
import 'package:template_flutter_asp/app/interactor/atoms/user_atom.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';
import 'package:template_flutter_asp/app/interactor/states/edit_user_state.dart';
import 'package:template_flutter_asp/app/interactor/states/user_state.dart';
import 'package:template_flutter_asp/generated/l10n.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockUserRepository mockRepository;

  setUpAll(() async {
    await S.load(const Locale.fromSubtags(languageCode: 'en'));
    mockRepository = MockUserRepository();
    injector.add<UserRepository>(() => mockRepository);
    injector.commit();
  });

  group('fetchUsers', () {
    test('should fetch users from repository and update userState', () async {
      await fetchUsers();

      expect(userState.value, isA<GettedUserState>());
      expect((userState.value as GettedUserState).users, mockRepository.users);
    });
  });

  group('updateUser', () {
    test('should update an user', () async {
      final newUser = UserModel(id: 1, name: 'Jane', isActive: true);
      await updateUser(newUser);

      expect(editUserState.value, isA<SavedUserState>());
    });

    test('should return an error when trying to update a non-existent user',
        () async {
      final newUser = UserModel(id: 100, name: 'Jane', isActive: true);
      await updateUser(newUser);

      expect(editUserState.value, isA<FailureEditUserState>());
    });
  });

  group('insertUser', () {
    test('should insert new user into repository and fetch', () async {
      final newUser = UserModel(id: 100, name: 'Jane', isActive: true);
      await insertUser(newUser);

      expect(editUserState.value, isA<SavedUserState>());
    });
  });

  group('deleteUser', () {
    test('should delete user from repository and fetch', () async {
      const todoId = 1;
      await deleteUser(todoId);
      expect(editUserState.value, isA<SavedUserState>());
    });

    test('should return an error when trying to delete a non-existent user',
        () async {
      const todoId = 100000;
      await deleteUser(todoId);
      expect(editUserState.value, isA<FailureEditUserState>());
    });
  });
}
