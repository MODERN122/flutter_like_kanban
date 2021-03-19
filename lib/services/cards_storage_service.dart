import 'package:dio/dio.dart';
import 'package:likekanban/models/app_card.dart';

class CardsStorageService {
  Dio _dio = Dio();

  Future<List<AppCard>> fetchCardsByRowName(String row, String token) async {
    // var cards = List<Card>();
    // try {
    //   final response = await _dio
    //       .get("https://trello.backend.tests.nekidaem.ru/api/v1/users/login/");
    //   cards = response.data.map<Card>((card) => Card.fromJson(card)).toList();
    // } on DioError catch (error) {
    //   print(error);
    // }
    // return cards;
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (Options options) {
      _dio.interceptors.requestLock.lock();
      options.headers["Authorization"] = token;
      _dio.interceptors.requestLock.unlock();
      return options;
    }));
    final response = await _dio
        .get("https://trello.backend.tests.nekidaem.ru/api/v1/cards/");
    return response.data
        .map<AppCard>((card) => AppCard.fromJson(card))
        .where((card) => card.row == row)
        .toList();
  }
}
