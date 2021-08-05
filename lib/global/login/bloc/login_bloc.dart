import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:likekanban/models/app_user.dart';
import 'package:likekanban/services/preference_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  final _userName = BehaviorSubject<String>()..value = "armada";
  final _password = BehaviorSubject<String>()..value = "FSH6zBZ0p9yH";
  final _user = BehaviorSubject<AppUser>();
  final _errorMessage = BehaviorSubject<String>();
  Dio _dio = Dio();

  // Getters
  Stream<String> get userName => _userName.stream.transform(validateUserName);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get isValid => CombineLatestStream.combine2(
      userName, password, (login, password) => true);
  Stream<AppUser> get user => _user.stream;
  Stream<String> get errorMessage => _errorMessage.stream;
  String get userToken => (_user == null) ? '' : _user.value.token;

  // Setters
  Function(String) get changeUserName => _userName.sink.add;
  Function(String) get changePassword => _password.sink.add;

  dispose() {
    _userName.close();
    _password.close();
    _user.close();
    _errorMessage.close();
  }

  // Validators
  final validateUserName = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, sink) {
    if (userName.length >= 4) {
      sink.add(userName.trim());
    } else {
      sink.addError('Minimum is 4 characters');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password.trim());
    } else {
      sink.addError('Minimum is 8 characters');
    }
  });

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginSended) {
      login();
    }
  }

  login() async {
    try {
      final response = await _dio.post(
          "https://trello.backend.tests.nekidaem.ru/api/v1/users/login/",
          data: {'username': _userName.value, 'password': _password.value});
      var user = AppUser.fromJson(response.data);
      if (user != null) {
        PreferenceUtils.setString("token", user.token);
        _user.sink.add(user);
      }
    } on DioError catch (error) {
      _errorMessage.sink.add(error.message);
      print(error);
    }
  }

  logout() async {
    _user.sink.add(null);
  }

  clearErrorMessage() {
    _errorMessage.sink.add('');
  }
}
