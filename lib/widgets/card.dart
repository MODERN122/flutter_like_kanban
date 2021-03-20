import 'package:flutter/widgets.dart';
import 'package:likekanban/styles/colors.dart';
import 'package:likekanban/styles/text.dart';

class ExtendedAppCard extends StatelessWidget {
  final int id;
  final String text;

  ExtendedAppCard(this.id, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 5.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        color: BaseColors.smoke,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text('ID: $id', style: TextStyles.cardTitle),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(text, style: TextStyles.cardBody),
          ),
        ],
      ),
    );
  }
}
