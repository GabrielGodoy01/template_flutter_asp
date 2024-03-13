import 'package:flutter_test/flutter_test.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('copyWith should return a new UserModel with updated values', () {
      final user = UserModel(id: 1, name: 'John', isActive: true);

      final updatedUser = user.copyWith(name: 'Jane');

      expect(updatedUser.id, equals(user.id));
      expect(updatedUser.name, equals('Jane'));
      expect(updatedUser.isActive, equals(user.isActive));
    });

    test(
        'copyWith should return a new UserModel with the same values if no changes are provided',
        () {
      final user = UserModel(id: 1, name: 'John', isActive: true);

      final updatedUser = user.copyWith();

      expect(updatedUser.id, equals(user.id));
      expect(updatedUser.name, equals(user.name));
      expect(updatedUser.isActive, equals(user.isActive));
    });

    test(
        'copyWith should return a new UserModel with updated values when all parameters are provided',
        () {
      final user = UserModel(id: 1, name: 'John', isActive: true);

      final updatedUser = user.copyWith(id: 2, name: 'Jane', isActive: false);

      expect(updatedUser.id, equals(2));
      expect(updatedUser.name, equals('Jane'));
      expect(updatedUser.isActive, isFalse);
    });
  });
}
