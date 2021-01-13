import 'dart:convert';

class Cards{
  final String id;
  final String row;
  final String seq_num;
  final String text;
  Cards({this.id, this.row, this.seq_num, this.text});

  factory Cards.fromJson(Map<String, dynamic> json){
    return Cards(
        id: json['id'],
        row: json['row'],
        seq_num: json['seq_num'],
        text: json['text']
    );
  }

  Map<String, dynamic> toJson()=>
      {
        'id' : id,
        'row' : row,
        'seq_num' : seq_num,
        'text' : text
      };
}