import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template_flutter_asp/app/data/mock_user_repository.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
import 'package:template_flutter_asp/generated/l10n.dart';

void main() {
  late MockUserRepository mockRepository;

  setUp(() async {
    await S.load(const Locale.fromSubtags(languageCode: 'en'));

    mockRepository = MockUserRepository();
  });

  group('MockUserRepository', () {
    test('getAll should return a list of users', () async {
      final users = await mockRepository.getAll();

      users.fold(
        (l) => fail(l.message),
        (r) {
          expect(r.length, equals(3));
          expect(r[0].id, equals(1));
          expect(r[0].name, equals('User 1'));
          expect(r[0].isActive, isTrue);
        },
      );
    });

    test('insert should add a new user to the list', () async {
      final newUser = UserModel(id: 4, name: 'User 4', isActive: true);

      final result = await mockRepository.insert(newUser);

      result.fold(
        (l) => fail(l.message),
        (r) => expect(r, equals(newUser)),
      );

      expect(mockRepository.users.length, equals(4));
    });

    test('insert should return an error with duplicated id', () async {
      final duplicatedUser = UserModel(id: 1, name: 'User 1', isActive: true);

      final result = await mockRepository.insert(duplicatedUser);

      result.fold(
        (l) => expect(l.message, equals('1')),
        (r) => fail('Should return an error'),
      );

      expect(mockRepository.users.length, equals(3));
    });

    test('update should update an existing user in the list', () async {
      final updatedUser =
          UserModel(id: 2, name: 'Updated User 2', isActive: false);

      final result = await mockRepository.update(updatedUser);

      result.fold(
        (l) => fail(l.message),
        (r) => expect(r, equals(updatedUser)),
      );

      expect(mockRepository.users.length, equals(3));
      expect(mockRepository.users[1].name, equals('Updated User 2'));
    });

    test('update should return an error with non-existent user', () async {
      final nonExistentUser =
          UserModel(id: 100, name: 'Non Existent User', isActive: false);

      final result = await mockRepository.update(nonExistentUser);

      result.fold(
        (l) => expect(l.message, equals('No items found for 100')),
        (r) => fail('Should return an error'),
      );

      expect(mockRepository.users.length, equals(3));
    });

    test('delete should remove a user from the list', () async {
      var userIdToDelete = 3;

      final result = await mockRepository.delete(userIdToDelete);

      result.fold(
        (l) => fail(l.message),
        (r) => expect(r, equals(unit)),
      );

      expect(mockRepository.users.length, equals(2));
    });

    test('delete should return an error with non-existent user', () async {
      var userIdToDelete = 100;

      final result = await mockRepository.delete(userIdToDelete);

      result.fold(
        (l) => expect(l.message, equals('No items found for 100')),
        (r) => fail('Should return an error'),
      );

      expect(mockRepository.users.length, equals(3));
    });
  });
}
