import 'dart:convert';

import 'package:clean_architecture_flutter/core/error/exception.dart';
import 'package:clean_architecture_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
//contract means abstract class

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTrivia> getConcreteNumberTrivia(int number);

  Future<NumberTrivia> getRandomNumberTrivia();
}

const ENDPOINT = 'http://numbersapi.com/';

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTrivia> getConcreteNumberTrivia(int number) =>
      _getTriviaFromUrl('$ENDPOINT $number');

  @override
  Future<NumberTrivia> getRandomNumberTrivia() =>
      _getTriviaFromUrl('$ENDPOINT/random');

  Future<NumberTrivia> _getTriviaFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
