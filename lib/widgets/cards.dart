import 'package:flutter/material.dart';
import 'package:likekanban/blocs/auth_bloc.dart';
import 'package:likekanban/blocs/cards_bloc.dart';
import 'package:likekanban/models/app_card.dart';
import 'package:likekanban/widgets/card.dart';
import 'package:provider/provider.dart';

class Cards extends StatelessWidget {
  final String row;
  Cards(this.row);

  @override
  Widget build(BuildContext context) {
    var cardsBloc = Provider.of<CardsBloc>(context);
    return StreamBuilder<List<AppCard>>(
      stream: cardsBloc.fetchCardsByRowName(row),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            var appCard = snapshot.data[index];
            return ExtendedAppCard(appCard.id, appCard.text);
          },
        );
      },
    );
  }
}
