import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:likekanban/global/cards/cards_page.dart';
import 'package:likekanban/global/login/login_page.dart';

import 'global/theme/bloc/theme_bloc.dart';

class App extends StatefulWidget {
  final FlutterI18nDelegate flutterI18nDelegate;

  App(this.flutterI18nDelegate);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: _builderWithTheme,
        ));
  }

  Widget _builderWithTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
      theme: state.themeData,
      home: LoginPage(),
      onGenerateRoute: Routes.materialRoutes,
      localizationsDelegates: [
        widget.flutterI18nDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

abstract class Routes {
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(builder: (context) => CardsPage());
      case "/login":
        return MaterialPageRoute(builder: (context) => LoginPage());
      default:
        return MaterialPageRoute(builder: (context) => LoginPage());
    }
  }
}
