import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/usecases/usecase.dart';
import 'package:clean_architecture_flutter/core/util/input_convertor.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/usecases/get_complete_number_trivia.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT = 'Input Failure';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {@required this.getConcreteNumberTrivia,
      @required this.getRandomNumberTrivia,
      @required this.inputConverter})
      : assert(getConcreteNumberTrivia != null),
        assert(getRandomNumberTrivia != null),
        assert(inputConverter != null);

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT);
        },
        (integer) async* {
          yield Loading();
          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    } else if (event is GetRandomNumberTrivia) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }
}

Stream<NumberTriviaState> _eitherLoadedOrErrorState(
  Either<Failure, NumberTrivia> either,
) async* {
  yield either.fold(
    (failure) => Error(message: _mapFailureToMessage(failure)),
    (trivia) => Loaded(trivia: trivia),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected Error';
  }
}
