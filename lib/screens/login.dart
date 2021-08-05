import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:likekanban/blocs/auth_bloc.dart';
import 'package:likekanban/global/theme/app_themes.dart';
import 'package:likekanban/global/theme/bloc/theme_bloc.dart';
import 'package:likekanban/services/preference_utils.dart';
import 'package:likekanban/styles/colors.dart';
import 'package:likekanban/widgets/button.dart';
import 'package:likekanban/widgets/textfield.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Locale _currentLang;
  StreamSubscription _userChangedSubscription;
  StreamSubscription _errorMessageSubscription;
  int _index = 0;
  @override
  BuildContext get context => super.context;

  @override
  void initState() {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    try {
      _index = PreferenceUtils.getInt("theme");
    } catch (e) {
      PreferenceUtils.setInt("theme", _index);
    }
    // got user -> home screen
    _userChangedSubscription = authBloc.user.listen((user) {
      if (user != null) Navigator.pushNamed(context, '/home');
    });
    // got error message -> show
    _errorMessageSubscription = authBloc.errorMessage.listen((message) {
      if (message.toString().isNotEmpty) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(FlutterI18n.translate(context, "alertdialog.error")),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => {Navigator.pop(context, 'Cancel')},
                child:
                    Text(FlutterI18n.translate(context, "alertdialog.cancel")),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text(FlutterI18n.translate(context, "alertdialog.ok")),
              ),
            ],
          ),
        );
      }
    });
    super.initState();
    Future.delayed(Duration.zero, () async {
      setState(() {
        _currentLang = FlutterI18n.currentLocale(context);
      });
    });
  }

  changeTheme(int index) {
    context.read<ThemeBloc>().add(ThemeChanged(theme: AppTheme.values[index]));
    PreferenceUtils.setInt("index", index);
    _index = index;
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "textfield.login.title")),
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
                color: BaseColors.pureWhite,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(5),
              child: ToggleSwitch(
                totalSwitches: 4,
                minWidth: 50,
                initialLabelIndex: _index,
                animate: true,
                labels: ["GreenLight", "BlueLight", "GreenDark", "BlueDark"],
                onToggle: (index) {
                  changeTheme(index);
                },
              )),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<String>(
              stream: authBloc.userName,
              builder: (context, snapshot) {
                return ExtendedTextField(
                  hintText:
                      FlutterI18n.translate(context, "textfield.login.hint"),
                  textInputType: TextInputType.name,
                  errorText:
                      FlutterI18n.translate(context, "textfield.login.error"),
                  onChanged: authBloc.changeUserName,
                );
              }),
          StreamBuilder<String>(
              stream: authBloc.password,
              builder: (context, snapshot) {
                return ExtendedTextField(
                  hintText:
                      FlutterI18n.translate(context, "textfield.password.hint"),
                  obscureText: true,
                  errorText: FlutterI18n.translate(
                      context, "textfield.password.error"),
                  onChanged: authBloc.changePassword,
                );
              }),
          StreamBuilder<bool>(
              stream: authBloc.isValid,
              builder: (context, snapshot) {
                return ExtendedButton(
                  buttonText:
                      FlutterI18n.translate(context, "button.login.enter"),
                  buttonType: (snapshot.data == true)
                      ? ButtonType.Enabled
                      : ButtonType.Disabled,
                  onPressed: authBloc.login,
                );
              }),
        ],
      ),
    );
  }
}
