import 'dart:async';
import 'package:app_datn_2022/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:developer';

part 'value_event.dart';

part 'value_state.dart';

class ValueBloc extends Bloc<ValueEvent, ValueState> {
  final _dbRef = FirebaseDatabase.instance.reference();
  late final _tableRef = _dbRef.child('node').child('n1');
  late DatabaseReference? dbCurrent = _dbRef.child('node').child('n1');
  Stream? onListenTemp;
  Stream? onListenGAS;
  Stream? onListenCO;
  Stream? onListenH;
  Stream? onListenD;
  Stream? onListenD10;

  List<double> data = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

  StreamController<List<double>> showingSections = StreamController();

  Stream<List<double>> get streamValue => showingSections.stream;

  Sink<List<double>> get sinkValue => showingSections.sink;

  void init() {
    _tableRef.onValue.listen((event) {
      final map = (event.snapshot.value as Map);
      log('map ==> $map');
      map.forEach((key, value) {
      });
      final lastKey = map.keys.last;
      log('lastKey ==> $lastKey');
      final subLastKey = (map[lastKey] as Map).keys.last;
      _register(dbCurrent?.child(lastKey ?? 'n1').child(subLastKey ?? ''));
    });
  }
  void _register(DatabaseReference? ref) {
    onListenTemp = ref?.child('T').onValue;
    onListenD10 = ref?.child('D10').onValue;
    onListenCO = ref?.child('CO').onValue;
    onListenH = ref?.child('H').onValue;
    onListenD = ref?.child('D').onValue;
    onListenGAS = ref?.child('GAS').onValue;

    sinkValue.add(data);

    listen(onListenCO, 1);
    listen(onListenD, 2);
    listen(onListenD10, 3);
    listen(onListenGAS, 4);
    listen(onListenH, 5);
    listen(onListenTemp, 6);
  }

  void listen(Stream? stream, int index) {
    stream?.listen((event) {
      final value = (event as Event).snapshot.value;
      log('value ==> $value');
      if (value == null) return;
      data[index - 1] = value * 1.0;
      sinkValue.add(data);
    });
  }

  ValueBloc() : super(Loading()) {
    on<Temp>((event, emit) {});
    on<CO2>((event, emit) {});
    on<UV>((event, emit) {});
    on<Test>((event, emit) {});
  }
}

const String dataKey = '_data';

class SharedKey{

}