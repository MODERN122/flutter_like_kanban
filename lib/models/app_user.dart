class AppUser {
  final String token;

  AppUser({this.token});

  AppUser.fromJson(Map<String, dynamic> parsedJson)
      : token = parsedJson['token'];
}
