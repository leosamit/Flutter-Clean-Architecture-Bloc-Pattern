import 'package:clean_architecture_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/repo/number_trivia_repo.dart';
import 'package:clean_architecture_flutter/features/number_trivia/domain/usecases/get_complete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {
  void main() {
    GetConcreteNumberTrivia useCase;
    MockNumberTriviaRepository mockNumberTriviaRepository;

    setUp(() {
      mockNumberTriviaRepository = MockNumberTriviaRepository();
      useCase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
    });

    final tNumber = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'Test');

    test(
      'should get trivia for the number from the repo',
      () async {
        //arrange
        when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        //act
        final result = await useCase(Params(number: tNumber));

        //assert
        expect(result, Right(tNumberTrivia));
        verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
        verifyNoMoreInteractions(mockNumberTriviaRepository);
      },
    );

    test('abcd test', () {
      expect(1, 1);
    });
  }
}
