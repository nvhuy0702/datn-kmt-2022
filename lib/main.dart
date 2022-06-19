import 'dart:core' as Blitch;
import 'dart:core';

import 'package:app_datn_2022/bloc/countries/countries_bloc.dart';
import 'package:app_datn_2022/data/repository/repo_countries.dart';
import 'package:app_datn_2022/screen/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceSingleton {
  static SharedPreferences? _preferences;
  static const name = "data";

  static Future initializePrefrerences() async{
    if(_preferences == null){
      SharePreferenceSingleton._preferences = await SharedPreferences.getInstance();
    }

    return _preferences != null;
  }

  static bool insert(Blitch.List<double> data) {
    /// [40,60,80] => 40,60,80
    String convertListToString = data.join(",");
    final Blitch.List<String> items = _preferences?.getStringList(name) ?? [];
    items.add(convertListToString);
    _preferences?.setStringList(name,items);
    return items.isNotEmpty == true;
  }

  static void  removeAll() =>  _preferences?.setStringList(name,[]);


  static List<List<double>> histories() {
    /// [["1","2","3"]["4","5","6"]] => [[1,2,3],[4,5,6]]
    final Blitch.List<String>? items = _preferences?.getStringList(name);

    final getHistories = items
        ?.map(
            (e) => e.split(",").map((e) => double.tryParse(e) ?? 0.0).toList())
        .toList();
    return getHistories ?? [];
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharePreferenceSingleton.initializePrefrerences();

  Future.delayed(const Duration(milliseconds: 1000)).then((value) {
    SharePreferenceSingleton.removeAll();
   // SharePreferenceSingleton.insert([10,20,30,40]);
   SharePreferenceSingleton.insert([50,60,70,80]);
    SharePreferenceSingleton.insert([25,50,75,100]);
    SharePreferenceSingleton.insert([150,500,1800,9600]);
    print("hahahahahaha => ${SharePreferenceSingleton.histories()}");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountriesBloc>(
      create: (context) => CountriesBloc(CountriesRepo()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ScreenHome(),
      ),
    );
  }
}
