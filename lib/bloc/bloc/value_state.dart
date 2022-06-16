part of 'value_bloc.dart';

@immutable
abstract class ValueState {}
class Loading extends ValueState {
  List<Object> get props => [];
}
class Loaded extends ValueState {
  @override
  List<Object> get props => [];
}
class Error extends ValueState {
  final String error;
  Error({required this.error});
  @override
  List<Object> get props => [error];
}