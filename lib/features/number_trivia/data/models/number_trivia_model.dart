import 'package:clean_architecture_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/cupertino.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({@required String text, @required int number})
      : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(text: json['text'], number: json['number']);
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'number': number};
  }
}
