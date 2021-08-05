import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:likekanban/global/cards/bloc/cards_bloc.dart';
import 'package:likekanban/global/theme/app_themes.dart';
import 'package:likekanban/global/theme/bloc/theme_bloc.dart';
import 'package:likekanban/widgets/textfield.dart';

import 'bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Locale _currentLang;
  StreamSubscription _userChangedSubscription;
  StreamSubscription _errorMessageSubscription;
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      setState(() {
        _currentLang = FlutterI18n.currentLocale(context);
      });
    });
  }

  changeLanguage() async {
    _currentLang =
        _currentLang.languageCode == 'en' ? Locale('ru') : Locale('en');
    await FlutterI18n.refresh(context, _currentLang);
    setState(() {});
  }

  @override
  void dispose() {
    _userChangedSubscription.cancel();
    _errorMessageSubscription.cancel();
    super.dispose();
  }

  bool _isDialogShow = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<CardsBloc>(
          create: (BuildContext context) => CardsBloc(),
        )
      ],
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          _loginBloc = context.read<LoginBloc>();
          // got user -> home screen
          _userChangedSubscription = _loginBloc.user.listen((user) {
            if (user != null) Navigator.pushNamed(context, '/home');
          });
          // got error message -> show
          _errorMessageSubscription = _loginBloc.errorMessage.listen((message) {
            if (message.toString().isNotEmpty && !_isDialogShow) {
              _isDialogShow = true;
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title:
                      Text(FlutterI18n.translate(context, "alertdialog.error")),
                  content: Text(message),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => {
                        _isDialogShow = false,
                        Navigator.pop(context, 'Cancel')
                      },
                      child: Text(
                          FlutterI18n.translate(context, "alertdialog.cancel")),
                    ),
                    TextButton(
                      onPressed: () =>
                          {_isDialogShow = false, Navigator.pop(context, 'OK')},
                      child: Text(
                          FlutterI18n.translate(context, "alertdialog.ok")),
                    ),
                  ],
                ),
              );
            }
          });
          return Scaffold(
            appBar: AppBar(
              title:
                  Text(FlutterI18n.translate(context, "textfield.login.title")),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: Ink(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.language),
                      onPressed: changeLanguage,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: Ink(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        context
                            .read<ThemeBloc>()
                            .add(ThemeChanged(theme: AppTheme.BlueDark));
                      },
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<String>(
                    stream: _loginBloc.userName,
                    builder: (context, snapshot) {
                      return ExtendedTextField(
                        hintText: FlutterI18n.translate(
                            context, "textfield.login.hint"),
                        textInputType: TextInputType.name,
                        errorText: FlutterI18n.translate(
                            context, "textfield.login.error"),
                        onChanged: _loginBloc.changeUserName,
                      );
                    }),
                StreamBuilder<String>(
                    stream: _loginBloc.password,
                    builder: (context, snapshot) {
                      return ExtendedTextField(
                        hintText: FlutterI18n.translate(
                            context, "textfield.password.hint"),
                        obscureText: true,
                        errorText: FlutterI18n.translate(
                            context, "textfield.password.error"),
                        onChanged: _loginBloc.changePassword,
                      );
                    }),
                StreamBuilder<bool>(
                    stream: _loginBloc.isValid,
                    builder: (context, snapshot) {
                      return TextButton(
                        onPressed: () {
                          _loginBloc.add(LoginSended());
                        },
                        child: Text(FlutterI18n.translate(
                            context, "button.login.enter")),
                      );
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
