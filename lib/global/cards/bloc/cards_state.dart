part of 'cards_bloc.dart';

abstract class CardsState extends Equatable {
  const CardsState();
  
  @override
  List<Object> get props => [];
}

class CardsInitial extends CardsState {}
