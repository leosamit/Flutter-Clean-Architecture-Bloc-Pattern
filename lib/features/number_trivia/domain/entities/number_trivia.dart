import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

//dart supports only referential equality
//even if two objects data is same, dart treats it as different entity unless they point same in memory
//using equatable it changes; objects with same data will be same
class NumberTrivia extends Equatable {
  final String text;
  final int number;

  NumberTrivia({
    @required this.text
    , @required this.number})
      : super([text, number]);
//super is super constructor. It is used so that equatable knows which property to equity happens on
}
