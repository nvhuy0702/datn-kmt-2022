import 'package:app_datn_2022/data/model/countries.dart';
import 'package:app_datn_2022/data/repository/repo_countries.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountriesRepo countriesRepo;

  late List<Data>? data;

  CountriesBloc(this.countriesRepo) : super(CountriesInitial()) {
    on<CountriesEvent>((event, emit) async {
      if (event is LoadData) {
        emit(CountriesLoading());

        await Future.delayed(const Duration(milliseconds: 600), () async {
          data = await countriesRepo.fetchDetails();

          emit(CountriesLoaded(data));
        });
      } else if (event is NavBack) {
        emit(CountriesInitial());
      }
    });
  }
}
