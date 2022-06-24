import 'package:app_datn_2022/bloc/control/control_bloc.dart';
import 'package:app_datn_2022/main.dart';
import 'package:app_datn_2022/widget/aqi_history.dart';
import 'package:app_datn_2022/widget/card_device_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ControlDevice extends StatefulWidget {
  const ControlDevice({Key? key}) : super(key: key);

  @override
  State<ControlDevice> createState() => _ControlDeviceState();
}

class _ControlDeviceState extends State<ControlDevice> {
  ControlBloc bloc = ControlBloc();
  bool isOnDevice1 = false;
  bool isOnDevice2 = false;

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Điều khiển thiết bị',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Row(
        children: [
          const SizedBox(
            width: 30,
          ),
          StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox();
              isOnDevice1 = (snapshot.data as Event).snapshot.value == "On";
              return CardDeviceState(
                onClick: bloc.onClickDevice1,
                pathIconOpen: 'assets/images/open_door.png',
                pathIconClose: 'assets/images/close_door.png',
                isOn: isOnDevice1,
                title: 'Device 1',
              );
            },
            stream: bloc.onDevice1,
          ),
          StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox();
              isOnDevice2 = (snapshot.data as Event).snapshot.value == "On";
              return CardDeviceState(
                onClick: bloc.onClickDevice2,
                pathIconOpen: 'assets/images/open_door.png',
                pathIconClose: 'assets/images/close_door.png',
                isOn: isOnDevice2,
                title: 'Device 2',
              );
            },
            stream: bloc.onDevice2,
          )
        ],
      ),
    );
  }
}
