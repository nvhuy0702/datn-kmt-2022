part of 'control_bloc.dart';

abstract class ControlEvent extends Equatable {
  const ControlEvent();

  @override
  List<Object> get props => [];
}
class Device1Event extends ControlEvent {
  final bool status1;
  const Device1Event({required this.status1});
}
class Device2Event extends ControlEvent {
  final bool status2;
  const Device2Event({required this.status2});
}
class SelectedMode extends ControlEvent {
  final bool mode;
  const SelectedMode({required this.mode});
}