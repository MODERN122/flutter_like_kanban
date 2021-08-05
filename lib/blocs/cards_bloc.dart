import 'package:likekanban/models/app_card.dart';
import 'package:likekanban/services/cards_storage_service.dart';
import 'package:likekanban/services/preference_utils.dart';
import 'package:rxdart/rxdart.dart';

class CardsBloc {
  final _db = CardsStorageService();
  final _cards = BehaviorSubject<List<AppCard>>();

  // Getters
  Stream<List<AppCard>> get cards => _cards.stream;

  // Setters
  Function(List<AppCard>) get changeCards => _cards.sink.add;

  Stream<List<AppCard>> fetchCardsByRowName(String row) => _db
      .fetchCardsByRowName(row, PreferenceUtils.getString("token"))
      .catchError((error) => print(error))
      .asStream();

  // Functions
  // fetchCardsByRowName(String row) => _db
  //         .fetchCardsByRowName(row)
  //         .then((cards) => changeCards(cards))
  //         .catchError((error) {
  //       print(error);
  //       changeCards(List<AppCard>());
  //     });

  dispose() {
    _cards.close();
  }
}
