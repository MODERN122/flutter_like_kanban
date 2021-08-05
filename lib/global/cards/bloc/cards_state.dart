part of 'cards_bloc.dart';

abstract class CardsState extends Equatable {
  CardsState({@required this.token});
  final String token;
  @override
  List<Object> get props => [];
}

class CardsInitial extends CardsState {}
