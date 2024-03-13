import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template_flutter_asp/app/data/mock_user_repository.dart';
import 'package:template_flutter_asp/app/helpers/functions/global_snackbar.dart';
import 'package:template_flutter_asp/app/injector.dart';
import 'package:template_flutter_asp/app/interactor/actions/user_actions.dart';
import 'package:template_flutter_asp/app/interactor/atoms/user_atom.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';
import 'package:template_flutter_asp/generated/l10n.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockUserRepository mockRepository;

  setUpAll(() async {
    await S.load(const Locale.fromSubtags(languageCode: 'en'));
    mockRepository = MockUserRepository();
    injector.add<UserRepository>(() => mockRepository);
  });

  group('fetchUsers', () {
    test('should fetch users from repository and update userState', () async {
      await fetchUsers();

      expect(userState.value, equals(mockRepository.users));
    });
  });

  group('updateUser', () {
    test('should insert a new user', () async {
      final newUser = UserModel(id: 5, name: 'Jane', isActive: true);

      await updateUser(newUser);

      expect(userState.value, contains(newUser));
    });
  });

  group('insertUser', () {
    test('should insert new user into repository and fetch', () async {
      final newUser = UserModel(id: 4, name: 'Jane', isActive: true);

      await insertUser(newUser);

      expect(userState.value, contains(newUser));
    });
  });

  group('deleteUser', () {
    test('should delete user from repository and fetch', () async {
      const todoId = 1;

      await deleteUser(todoId);

      expect(userState.value.length, equals(4));
    });
  });
}
