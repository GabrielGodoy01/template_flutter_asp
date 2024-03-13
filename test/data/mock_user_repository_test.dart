import 'package:flutter_test/flutter_test.dart';
import 'package:template_flutter_asp/app/data/mock_user_repository.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';

void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  group('MockUserRepository', () {
    test('getAll should return a list of users', () async {
      final users = await mockRepository.getAll();

      expect(users.length, equals(3));
      expect(users[0].id, equals(1));
      expect(users[0].name, equals('User 1'));
      expect(users[0].isActive, isTrue);
    });

    test('insert should add a new user to the list', () async {
      final newUser = UserModel(id: 4, name: 'User 4', isActive: true);

      final insertedUser = await mockRepository.insert(newUser);

      expect(insertedUser, equals(newUser));
      expect(mockRepository.users.length, equals(4));
    });

    test('update should update an existing user in the list', () async {
      final updatedUser =
          UserModel(id: 2, name: 'Updated User 2', isActive: false);

      final returnedUser = await mockRepository.update(updatedUser);

      expect(returnedUser, equals(updatedUser));
      expect(mockRepository.users.length, equals(3));
      expect(mockRepository.users.last.name, equals('Updated User 2'));
    });

    test('delete should remove a user from the list', () async {
      var userIdToDelete = 3;

      final deleted = await mockRepository.delete(userIdToDelete);

      expect(deleted, isTrue);
      expect(mockRepository.users.length, equals(2));
      expect(mockRepository.users.any((user) => user.id == userIdToDelete),
          isFalse);
    });
  });
}
