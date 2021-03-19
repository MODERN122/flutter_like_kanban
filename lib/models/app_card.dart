class AppCard {
  final int id;
  final String row;
  final int seqNum;
  final String text;

  AppCard({this.id, this.row, this.seqNum, this.text});

  AppCard.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        row = parsedJson['row'],
        seqNum = parsedJson['seq_num'],
        text = parsedJson['text'];
}
