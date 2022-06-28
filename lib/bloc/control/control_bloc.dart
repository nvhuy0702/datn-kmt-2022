import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

part 'control_event.dart';
part 'control_state.dart';

class ControlBloc extends Bloc<ControlEvent, ControlState> {
  final _dbRef = FirebaseDatabase.instance.reference();
  late final tableRef = _dbRef.child('control').child("device");
  Stream? onDevice1;
  Stream? onDevice2;

  void init() {
    onDevice1 = tableRef
        .child('fan')
        .onValue;
    onDevice2 = tableRef
        .child('window')
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
      await tableRef.update({
        'fan': event.status1 == true ? 1 : 0,
      });
    });
    on<Device2Event>((event, emit) async {
      await tableRef.update({
        'window': event.status2 == true ?  1 : 0,
      });
    });
  }
}