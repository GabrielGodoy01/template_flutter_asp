import 'package:auto_injector/auto_injector.dart';
import 'package:template_flutter_asp/app/helpers/environments/environment_config.dart';
import 'package:template_flutter_asp/app/helpers/services/http_service.dart';
import 'package:template_flutter_asp/app/helpers/services/uno/uno_http_service.dart';
import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';

final injector = AutoInjector();

void registerInstances() {
  injector.add<HttpService>(UnoHttpService.new);
  injector
      .addLazySingleton<UserRepository>(() => EnvironmentConfig.getUserRepo());
  injector.commit();
}
