import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

part 'control_event.dart';
part 'control_state.dart';

class ControlBloc extends Bloc<ControlEvent, ControlState> {
  final _dbRef = FirebaseDatabase.instance.reference();
  late final tableRef = _dbRef.child('node').child("ControlDevice");
  Stream? onDevice1;
  Stream? onDevice2;

  void init() {
    onDevice1 = tableRef
        .child('StatusInRoom')
        .child('Device 1')
        .onValue;
    onDevice2 = tableRef
        .child('StatusInRoom')
        .child('Device 2')
        .onValue;
    emit(Successful());
  }

  void onClickDevice1(bool status1) {
    add(Device1Event(status1: status1));
  }

  void onClickDevice2(bool status2) {
    add(Device2Event(status2: status2));
  }

  ControlBloc() : super(Loading()) {
    on<Device1Event>((event, emit) async {
      await tableRef.child("StatusInRoom").update({
        'Device 1': event.status1 == true ? 'On' : 'Off',
      });
    });
    on<Device2Event>((event, emit) async {
      await tableRef.child("StatusInRoom").update({
        'Device 2': event.status2 == true ? 'On' : 'Off',
      });
    });
  }
}