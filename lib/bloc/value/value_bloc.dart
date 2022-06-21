import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';

part 'value_event.dart';

part 'value_state.dart';

class ValueBloc extends Bloc<ValueEvent, ValueState> {
  final _dbRef = FirebaseDatabase.instance.reference();
  late final _tableRef = _dbRef.child('node').child('n1');
  late DatabaseReference? dbCurrent = _dbRef.child('node').child('n1');
  Stream? onListenTemp;
  Stream? onListenCO2;
  Stream? onListenUV;
  Stream? onListenCO;
  Stream? onListenH;
  Stream? onListenD;

  List<double> data = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

  StreamController<List<double>> showingSections = StreamController();

  Stream<List<double>> get streamValue => showingSections.stream;

  Sink<List<double>> get sinkValue => showingSections.sink;

  void init() {
    _tableRef.onValue.listen((event) {
      final map = (event.snapshot.value as Map);
      final lastKey = map.keys.last;
      print("last key => $lastKey");
      final subLastKey = (map[lastKey] as Map).keys.last;
      _register(dbCurrent?.child(lastKey ?? 'n1').child(subLastKey ?? ''));
    });
  }

  void _register(DatabaseReference? ref) {
    onListenTemp = ref?.child('T').onValue;
    onListenCO2 = ref?.child('CO2').onValue;
    onListenUV = ref?.child('UV').onValue;
    onListenCO = ref?.child('CO').onValue;
    onListenH = ref?.child('H').onValue;
    onListenD = ref?.child('D').onValue;

    sinkValue.add(data);

    listen(onListenTemp, 1);
    listen(onListenCO2, 2);
    listen(onListenUV, 3);
    listen(onListenCO, 4);
    listen(onListenH, 5);
    listen(onListenD, 6);
  }

  void listen(Stream? stream, int index) {
    stream?.listen((event) {
      final value = (event as Event).snapshot.value;
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
