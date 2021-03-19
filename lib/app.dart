import 'package:flutter/material.dart';
import 'package:likekanban/blocs/auth_bloc.dart';
import 'package:likekanban/blocs/cards_bloc.dart';
import 'package:likekanban/styles/colors.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'screens/login.dart';

final authBloc = AuthBloc();
final cardsBloc = CardsBloc();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => authBloc),
          Provider(create: (context) => cardsBloc),
        ],
        child: MaterialApp(
          home: Login(),
          onGenerateRoute: Routes.materialRoutes,
          theme: ThemeData(
              scaffoldBackgroundColor: BaseColors.background,
              appBarTheme: AppBarTheme(color: BaseColors.header)),
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
