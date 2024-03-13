import 'package:uno/uno.dart';
import 'package:template_flutter_asp/app/helpers/services/http_service.dart';

class UnoHttpService extends HttpService {
  final uno = Uno();

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
