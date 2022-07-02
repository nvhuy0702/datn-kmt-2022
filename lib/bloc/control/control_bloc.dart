import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

part 'control_event.dart';

part 'control_state.dart';

class ControlBloc extends Bloc<ControlEvent, ControlState> {
  final _dbRef = FirebaseDatabase.instance.reference();
  late final tableRef = _dbRef.child('control').child("device");
  late final tableRef1 = _dbRef.child('control').child('config');
  Stream? onDevice1;
  Stream? onDevice2;
  Stream? onSelectedMode;

  void init() {
    onDevice1 = tableRef.child('fan').onValue;
    onDevice2 = tableRef.child('window').onValue;
    onSelectedMode = tableRef1.child('mode').onValue;
    emit(Successful());
  }

  void onClickDevice1(bool status1) {
    add(Device1Event(status1: status1));
  }

  void onClickDevice2(bool status2) {
    add(Device2Event(status2: status2));
  }

  void onSelectedMode1(bool mode) {
    add(SelectedMode(mode: mode));
  }

  ControlBloc() : super(Loading()) {
    on<Device1Event>((event, emit) async {
      await tableRef.update({
        'fan': event.status1 == true ? 1 : 0,
      });
    });
    on<Device2Event>((event, emit) async {
      await tableRef.update({
        'window': event.status2 == true ? 1 : 0,
      });
    });
    on<SelectedMode>((event, emit) async {
      await tableRef1.update({
        'mode': event.mode == true ? 'auto' : 'manual',
      });
    });
  }
}
