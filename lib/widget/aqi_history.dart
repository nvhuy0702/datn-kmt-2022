import 'package:app_datn_2022/extension/to_name.dart';
import 'package:flutter/material.dart';
import 'package:app_datn_2022/model/aqi_datn.dart' as TripleH;
class AqiHistory extends StatefulWidget {

  const AqiHistory({Key? key, this.condition}) : super(key: key);
  final TripleH.aqiDATN? condition;
  @override
  State<AqiHistory> createState() => _AqiHistoryState();
}

class _AqiHistoryState extends State<AqiHistory> {
  int value = 55;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 390,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(-3,6),
            blurRadius: 6,
            color: Colors.grey
          )
        ]
      ),
      child: Column(
        children: [
          const SizedBox(height: 10,),
          const Text(
            '20-6-2021',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              SizedBox(width: 10,),
              _header(widget.condition),
            ],
          )
        ],
      ),
    );
  }
  Row _header(TripleH.aqiDATN? condition) {
    return Row(
      children: [
        const SizedBox(
          width: 4,
        ),
        Container(
          height: 150,
          width: 360,
          decoration: BoxDecoration(
            color: TripleH.aqiDATN.initializeFromRange(range: 35).color,
            boxShadow: [
              BoxShadow(
                offset: const Offset(3, 1),
                blurRadius: 10,
                color: TripleH.aqiDATN.initializeFromRange(range: 35).color ??
                    Colors.white,
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Image(
                image: AssetImage(TripleH.aqiDATN
                    .initializeFromRange(range: 23)
                    .pathAvatar
                    .toString()),
                height: 120,
                width: 120,
              ),
              const SizedBox(
                width: 40,
              ),
              _value(),
              const SizedBox(
                width: 50,
              ),
              _status(condition)
            ],
          ),
        ),
      ],
    );
  }
  Text _status(TripleH.aqiDATN? conditionDATN) {
    return Text(
      TripleH.aqiDATN.initializeFromRange(range: 20).state.getName,
      style: const TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
  Column _value() {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          value.toString(),
          style: const TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'AQI',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ],
    );
  }

}
