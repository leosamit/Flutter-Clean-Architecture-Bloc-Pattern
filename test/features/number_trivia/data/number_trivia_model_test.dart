import 'dart:convert';

import 'package:clean_architecture_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Text Test');

  test('should be a subclass of number trivia entity', () async {
    //arrange
    //act
    //assert

    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('from json', () {
    test('should return valid model  when JSON is interger', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //assert
      expect(result, tNumberTriviaModel);
    });
  });
}
