part of 'cards_bloc.dart';

class CardsEvent extends Equatable {
  const CardsEvent();

  @override
  List<Object> get props => [];
}

class CardsGet extends CardsEvent {
  String row;
  CardsGet(this.row);
}
