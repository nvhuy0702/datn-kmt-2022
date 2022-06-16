
import 'package:app_datn_2022/bloc/countries/countries_bloc.dart';
import 'package:app_datn_2022/screen/aqi_world.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chất lượng không khí',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<CountriesBloc, CountriesState>(
        listener: (context, state) {},
        builder: (context, state) {
         if(state is CountriesLoaded) {
           return AqiWorld();
         }
         return SizedBox();
        },
      ),
    );
  }


}
