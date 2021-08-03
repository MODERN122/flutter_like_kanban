import 'package:dio/dio.dart';
import 'package:likekanban/models/app_card.dart';

class CardsStorageService {
  Dio _dio = Dio();

  Future<List<AppCard>> fetchCardsByRowName(String row, String token) async {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (Options options) {
      _dio.interceptors.requestLock.lock();
      options.headers["Authorization"] = 'JWT $token';
      _dio.interceptors.requestLock.unlock();
      return options;
    }));
    final response = await _dio
        .get("https://trello.backend.tests.nekidaem.ru/api/v1/cards/?row=$row");
    return response.data
        .map<AppCard>((card) => AppCard.fromJson(card))
        .toList();
  }
}
