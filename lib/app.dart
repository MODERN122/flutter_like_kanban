import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:likekanban/blocs/auth_bloc.dart';
import 'package:likekanban/blocs/cards_bloc.dart';
import 'package:likekanban/styles/colors.dart';
import 'package:likekanban/screens/home.dart';
import 'package:likekanban/screens/login.dart';
import 'package:provider/provider.dart';

import 'global/theme/bloc/theme_bloc.dart';

final authBloc = AuthBloc();
final cardsBloc = CardsBloc();

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
    return MultiProvider(
        providers: [
          Provider(create: (context) => authBloc),
          Provider(create: (context) => cardsBloc),
        ],
        child: MaterialApp(
          home: Login(),
          onGenerateRoute: Routes.materialRoutes,
          theme: state.themeData,
          localizationsDelegates: [
            widget.flutterI18nDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        ));
  }

  @override
  void dispose() {
    authBloc.dispose();
    cardsBloc.dispose();
    super.dispose();
  }
}

abstract class Routes {
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(builder: (context) => Home());
      case "/login":
        return MaterialPageRoute(builder: (context) => Login());
      default:
        return MaterialPageRoute(builder: (context) => Login());
    }
  }
}
