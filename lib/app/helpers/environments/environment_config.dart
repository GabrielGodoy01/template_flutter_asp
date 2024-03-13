// ignore_for_file: constant_identifier_names

import 'package:template_flutter_asp/app/data/repositories/mock_user_repository.dart';
import 'package:template_flutter_asp/app/data/repositories/uno_user_repository.dart';
import 'package:template_flutter_asp/app/helpers/enums/environment_enum.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';

class EnvironmentConfig {
  static const MSS_BASE_URL = String.fromEnvironment('MSS_BASE_URL');
  static const ENV = String.fromEnvironment(
    'ENV',
  );

  static UserRepository getUserRepo() {
    EnvironmentEnum value = EnvironmentEnum.values.firstWhere(
      (element) {
        return element.name.toUpperCase() == ENV.toUpperCase();
      },
      orElse: () => EnvironmentEnum.DEV,
    );
    if (value == EnvironmentEnum.DEV) {
      return MockUserRepository();
    } else {
      return UnoUserRepository();
    }
  }
}
