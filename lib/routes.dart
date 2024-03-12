import 'package:routefly/routefly.dart';

import 'app/(public)/home_page.dart' as home;
import 'app/(public)/splash_page.dart' as splash;

List<RouteEntity> get routes => [
      RouteEntity(
        key: '/home',
        uri: Uri.parse('/home'),
        routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
          ctx,
          settings,
          const home.HomePage(),
        ),
      ),
      RouteEntity(
        key: '/splash',
        uri: Uri.parse('/splash'),
        routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
          ctx,
          settings,
          const splash.SplashPage(),
        ),
      ),
    ];

const routePaths = (
  path: '/',
  home: '/home',
  splash: '/splash',
);
