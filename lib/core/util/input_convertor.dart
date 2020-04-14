import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integerNum = int.parse(str);
      if (integerNum < 0) throw FormatException();
      return Right(integerNum);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
