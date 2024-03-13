import 'package:routefly/routefly.dart';
import 'package:template_flutter_asp/app/helpers/environments/environment_config.dart';
import 'package:template_flutter_asp/routes.dart';
import 'package:uno/uno.dart';
import 'package:template_flutter_asp/app/helpers/services/http_service.dart';

class UnoHttpService extends HttpService {
  final uno = Uno(
    baseURL: EnvironmentConfig.MSS_BASE_URL,
  );

  UnoHttpService() {
    uno.interceptors.request.use(
      (request) {
        request.headers['Authorization'] =
            'Bearer SoanM6sDfT3E_lU5Zp5pFA8eZMJQdCaDIXhiMunE_zXYhXAM8g';
        return request;
      },
      onError: (error) {
        error.response!.status == 401
            ? Routefly.navigate(routePaths.splash)
            : null;
        return error;
      },
    );
  }

  @override
  Future get(String url) {
    return uno.get(url);
  }

  @override
  Future post(String url, {data}) {
    return uno.post(url, data: data);
  }

  @override
  Future put(String url, {data}) {
    return uno.put(url, data: data);
  }

  @override
  Future delete(String url, {data}) {
    return uno.delete(url, data: data);
  }

  @override
  Future patch(String url, {data}) {
    return uno.patch(url, data: data);
  }
}
