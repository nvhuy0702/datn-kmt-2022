import 'package:app_datn_2022/module/status.dart';
import 'package:app_datn_2022/widget/screen/air_quality_item.dart';
import 'package:flutter/material.dart';
class ScreenPlace extends StatefulWidget {
  const ScreenPlace({Key? key}) : super(key: key);

  @override
  State<ScreenPlace> createState() => _ScreenPlaceState();
}

class _ScreenPlaceState extends State<ScreenPlace> {
  List<Status> statusAir = [
    Status(status: 'Tốt', color: const Color(0xffA0D995)),
    Status(status: 'Trung bình', color: const Color(0xffF7EC09)),
    Status(status: 'Xấu', color: const Color(0xffFFC54D)),
    Status(status: 'Kém', color: const Color(0xffF24C4C)),
    Status(status: 'Rất kém', color: const Color(0xff570A57)),
    Status(status: 'Nguy hại', color: const Color(0xffA97155)),
  ];
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return _item(index);
                }),
          ),
        ));
  }

  Column _item(int index) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        Row(
          children: const [
            SizedBox(
              width: 15,
            ),
            AirQualityItem(),
          ],
        ),
      ],
    );
  }
}
