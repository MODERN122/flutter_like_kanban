import 'dart:async';
import 'package:flutter/material.dart';
import 'package:likekanban/blocs/auth_bloc.dart';
import 'package:likekanban/widgets/button.dart';
import 'package:likekanban/widgets/textfield.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  StreamSubscription _userChangedSubscription;
  StreamSubscription _errorMessageSubscription;

  @override
  void initState() {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    // got user -> home screen
    _userChangedSubscription = authBloc.user.listen((user) {
      if (user != null) Navigator.pushReplacementNamed(context, '/home');
    });
    // got error message -> show
    _errorMessageSubscription = authBloc.errorMessage.listen((message) {
      if (message.isNotEmpty) print(message); // showDialog??
    });
    super.initState();
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
        title: Text('Kanban'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<String>(
              stream: authBloc.userName,
              builder: (context, snapshot) {
                return ExtendedTextField(
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text,
                  errorText: snapshot.error,
                  onChanged: authBloc.changeUserName,
                );
              }),
          StreamBuilder<String>(
              stream: authBloc.password,
              builder: (context, snapshot) {
                return ExtendedTextField(
                  hintText: 'Enter your password',
                  obscureText: true,
                  errorText: snapshot.error,
                  onChanged: authBloc.changePassword,
                );
              }),
          StreamBuilder<bool>(
              stream: authBloc.isValid,
              builder: (context, snapshot) {
                return ExtendedButton(
                  buttonText: 'Log in',
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
