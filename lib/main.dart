import 'package:app_datn_2022/bloc/countries/countries_bloc.dart';
import 'package:app_datn_2022/data/repository/repo_countries.dart';
import 'package:app_datn_2022/screen/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountriesBloc>(
      create: (context) => CountriesBloc(CountriesRepo()),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ScreenHome(),
      ),
    );
  }
}
