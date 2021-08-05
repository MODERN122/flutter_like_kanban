import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:likekanban/models/app_card.dart';
import 'package:likekanban/services/cards_storage_service.dart';
import 'package:likekanban/services/preference_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc() : super(CardsInitial());

  final _db = CardsStorageService();
  final _cards = BehaviorSubject<List<AppCard>>();

  // Getters
  Stream<List<AppCard>> get cards => _cards.stream;

  // Setters
  Function(List<AppCard>) get changeCards => _cards.sink.add;

  Future<void> fetchCardsByRowName(String row) async {
    String token = PreferenceUtils.getString("token");
    var cards = await _db
        .fetchCardsByRowName(row, token)
        .catchError((error) => print(error));
    if (cards != null) {
      _cards.sink.add(cards);
    }
  }

  dispose() {
    _cards.close();
  }

  @override
  Stream<CardsState> mapEventToState(
    CardsEvent event,
  ) async* {
    if (event is CardsGet) {
      fetchCardsByRowName(event.row);
    }
  }
}
