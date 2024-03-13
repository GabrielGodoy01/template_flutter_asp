import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';
import 'package:template_flutter_asp/app/helpers/functions/global_snackbar.dart';
import 'package:template_flutter_asp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      title: 'ASP Template',
      debugShowCheckedModeBanner: false,
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.splash,
      ),
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
