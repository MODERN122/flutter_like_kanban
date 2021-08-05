import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likekanban/global/cards/bloc/cards_bloc.dart';
import 'package:likekanban/models/app_card.dart';
import 'package:likekanban/widgets/card.dart';
import 'package:provider/provider.dart';

String _row;

class Cards extends StatefulWidget {
  Cards(String row) {
    _row = row;
  }
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  StreamSubscription _userChangedSubscription;
  List<AppCard> cards;
  @override
  void dispose() {
    _userChangedSubscription.cancel();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardsBloc(),
      child: BlocBuilder<CardsBloc, CardsState>(
        builder: (context, state) {
          _userChangedSubscription =
              context.read<CardsBloc>().cards.listen((cardsRes) {
            if (cardsRes != null) {
              setState(() {
                cards = cardsRes;
              });
            }
          });
          context.read<CardsBloc>().add(CardsGet(_row));
          // got user -> home screen
          return ListView.builder(
            itemCount: cards?.length ?? 0,
            itemBuilder: (context, index) {
              var appCard = cards[index];
              return ExtendedAppCard(appCard?.id, appCard?.text);
            },
          );
        },
      ),
    );
  }
}
