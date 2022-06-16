import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
part 'value_event.dart';
part 'value_state.dart';

class ValueBloc extends Bloc<ValueEvent, ValueState> {
  final _dbRef = FirebaseDatabase.instance.reference();
  late final _tableRef = _dbRef.child('node').child('n1').child('n1');
  Stream? onListenTemp;
  Stream? onListenCO2;
  Stream? onListenUV;
  Stream? onListenTest;

  List<int> data = [0, 0, 0, 0];

  StreamController<List<int>> showingSections = StreamController();

  Stream<List<int>> get streamValue => showingSections.stream;

  Sink<List<int>> get sinkValue => showingSections.sink;

  void init() {
    onListenTemp = _tableRef.child('T').onValue;
    onListenCO2 = _tableRef.child('CO2').onValue;
    onListenUV = _tableRef.child('UV').onValue;
    onListenTest = _tableRef.child('CO').onValue;

    sinkValue.add(data);

    listen(onListenTemp,1);
    listen(onListenCO2,2);
    listen(onListenUV,3);
    listen(onListenTest,4);
  }
  void listen(Stream? stream, int index) {
    stream?.listen((event) {
      final value = (event as Event).snapshot.value;
      if(value == null) return;
      data[index - 1] = value;
      print('value $value');
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
