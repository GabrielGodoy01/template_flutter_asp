import 'package:auto_injector/auto_injector.dart';
import 'package:template_flutter_asp/app/data/mock_user_repository.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';

final injector = AutoInjector();

void registerInstances() {
  injector.addLazySingleton<UserRepository>(MockUserRepository.new);
  injector.commit();
}
