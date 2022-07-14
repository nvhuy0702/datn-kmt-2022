import 'package:app_datn_2022/bloc/control/control_bloc.dart';
import 'package:app_datn_2022/main.dart';
import 'package:app_datn_2022/screen/screen_home.dart';
import 'package:app_datn_2022/widget/card_device_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

class ControlDevice extends StatefulWidget {
  const ControlDevice({Key? key}) : super(key: key);

  @override
  State<ControlDevice> createState() => _ControlDeviceState();
}

class _ControlDeviceState extends State<ControlDevice> {
  ControlBloc bloc = ControlBloc();
  bool isOnDevice1 = false;
  bool isOnDevice2 = false;
  bool isAuto = false;

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
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 30,),
              StreamBuilder(
                builder: (context, snapshot) {
                  if (snapshot.data == null) return const SizedBox();
                  isOnDevice1 = (snapshot.data as Event).snapshot.value == 1;
                  return CardDeviceState(
                    onClick: bloc.onClickDevice1,
                    pathIconOpen: 'assets/images/fan_on.png',
                    pathIconClose: 'assets/images/fan_off.png',
                    isOn: isOnDevice1,
                    title: 'Device 1',
                  );
                },
                stream: bloc.onDevice1,
              ),
              StreamBuilder(
                builder: (context, snapshot) {
                  if (snapshot.data == null) return const SizedBox();
                  isOnDevice2 = (snapshot.data as Event).snapshot.value == 1;
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
          const SizedBox(height: 10,),
          StreamBuilder(builder: (context, snapshot) {
            if (snapshot.data == null) return const SizedBox();
            isAuto = (snapshot.data as Event).snapshot.value == 'auto';
            return Card(
              child: SizedBox(
                width: 200,
                height: 100,
                child: Row(
                  children: [
                    const SizedBox(width: 30,),
                    Text(
                      'Mode : ',
                      style: GoogleFonts.crimsonPro(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(width: 10,),
                    FlutterSwitch(
                      activeText: "Auto",
                      inactiveText: "Manual",
                      value: isAuto,
                      valueFontSize: 10.0,
                      width: 80,
                      borderRadius: 30.0,
                      showOnOff: true,
                      onToggle: bloc.onSelectedMode1,
                    ),
                  ],
                ),
              ),
            );
          },
            stream: bloc.onSelectedMode,
          )
        ],
      ),
    );
  }
}
