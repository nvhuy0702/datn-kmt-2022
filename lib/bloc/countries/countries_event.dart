part of 'countries_bloc.dart';

@immutable
abstract class CountriesEvent {}

class LoadData extends CountriesEvent {}

class NavBack extends CountriesEvent {}