part of 'value_bloc.dart';

@immutable
abstract class ValueEvent extends Equatable {
  const ValueEvent();

  @override
  List<Object> get props => [];
}
class Temp extends ValueEvent {
  final int valueTemp;
  const Temp({required this.valueTemp});
}
class CO2 extends ValueEvent {
  final int valueCO2;
  const CO2({required this.valueCO2});
}
class UV extends ValueEvent {
  final int valueUV;
  const UV({required this.valueUV});
}
class Test extends ValueEvent {
  final int valueTest;
  const Test({required this.valueTest});
}