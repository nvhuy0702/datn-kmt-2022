import 'package:app_datn_2022/screen/control_device.dart';
import 'package:app_datn_2022/widget/air_quality_item.dart';
import 'package:flutter/material.dart';

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
            'Đồ án KMT',
            style: TextStyle(
                color: Color(0xff4467E7),
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ControlDevice())
                  );
                },
                icon: const Image(
                  image: AssetImage('assets/images/control_device.png'),
                )
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: const AirQualityItem());
  }
}
