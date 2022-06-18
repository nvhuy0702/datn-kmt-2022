import 'package:app_datn_2022/bloc/value/value_bloc.dart';
import 'package:app_datn_2022/extension/to_name.dart';
import 'package:app_datn_2022/model/aqi_datn.dart' as TripleH;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

class AirQualityItem extends StatefulWidget {

  const AirQualityItem({
    Key? key,
    this.condition,
  }) : super(key: key);

  final TripleH.aqiDATN? condition;

  @override
  State<AirQualityItem> createState() => _AirQualityItemState();
}


class _AirQualityItemState extends State<AirQualityItem> {
  ValueBloc valueBloc = ValueBloc();
  final primaryColor = const Color(0xFFE0E0E0);
  int value = 55;

  @override
  void initState() {
    valueBloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10,),
              _header(widget.condition),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          _parameter(),
        ],
      ),
    );
  }

  Container _weather(String image, String valueWeather) {
    return Container(
      width: 140,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: primaryColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(-20, -20),
            blurRadius: 60,
            color: Colors.white,
            inset: true,
          ),
          BoxShadow(
              offset: Offset(3, 4), blurRadius: 10, color: Color(0xFFBEBEBE))
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Image(image: AssetImage(image)),
          const SizedBox(
            width: 10,
          ),
          Text(valueWeather)
        ],
      ),
    );
  }

  Widget _parameter() {
    return StreamBuilder(
      stream: valueBloc.streamValue,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        final data = snapshot.data as List<double>;
        return Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 40,),
                _weather('assets/images/02d.png', '${data[0].toStringAsFixed(1)} °C'),
                const SizedBox(
                  width: 20,
                ),
                _weather('assets/images/hum.png', '${data[4].toDouble()} %'),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(height: 40,),
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width - 32,
              child: Wrap(
                spacing: 30,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _item(
                      'CO2',
                      data[1].toDouble(),
                       Colors.blue
                  ),
                  _item(
                      'UV',
                      data[2].toDouble(),
                       Colors.blue
                  ),
                  _item(
                      'CO',
                      data[3].toDouble(),
                      TripleH.CO.initializeFromRange(value: 46000).color
                  ),
                  _item(
                      'D',
                      data[5].roundToDouble(),
                      TripleH.PM10.initializeFromRange(value: 275).color
                  ),
                ],
              ),
            ),
          ],
        );
      },
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
          width: 380,
          decoration: BoxDecoration(
            color: TripleH.aqiDATN.initializeFromRange(range: 35).color,
            boxShadow: [
              BoxShadow(
                offset: const Offset(3,1),
                blurRadius: 10,
                color: TripleH.aqiDATN.initializeFromRange(range: 35).color ?? Colors.white,
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Image(
                image: AssetImage(TripleH.aqiDATN.initializeFromRange(range: 23).pathAvatar.toString()),
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
      TripleH.aqiDATN.initializeFromRange(range: 120).state.getName,
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
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
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
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

  Container _item(String element, double value, Color color) {
    return Container(
      width: 90,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: primaryColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(-20, -20),
            blurRadius: 60,
            color: Colors.white,
            inset: true,
          ),
          BoxShadow(
              offset: Offset(3, 4), blurRadius: 10, color: Color(0xFFBEBEBE))
        ],
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(60 / 2)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    value.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              element,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

