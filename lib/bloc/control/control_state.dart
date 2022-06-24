part of 'control_bloc.dart';

abstract class ControlState extends Equatable {}

class Loading extends ControlState {
  @override
  List<Object> get props => [];
}
class Successful extends ControlState {
  @override
  List<Object> get props => [];
}
class Error extends ControlState {
  final String error;
  Error({required this.error});
  @override
  List<Object> get props => [error];
}
