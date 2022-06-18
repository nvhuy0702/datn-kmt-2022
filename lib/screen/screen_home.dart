import 'package:app_datn_2022/widget/screen/air_quality_item.dart';
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
                color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.history,
                  color: Colors.black,
                  size: 30,
                ))
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: const AirQualityItem());
  }
}
