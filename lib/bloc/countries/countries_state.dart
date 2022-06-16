part of 'countries_bloc.dart';

@immutable
abstract class CountriesState {}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesLoaded extends CountriesState {
  final List<Data>? data;

  CountriesLoaded(this.data);
}
