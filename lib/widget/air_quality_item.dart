import 'package:app_datn_2022/bloc/value/value_bloc.dart';
import 'package:app_datn_2022/extension/to_name.dart';
import 'package:app_datn_2022/model/aqi_datn.dart' as TripleH;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:intl/intl.dart';

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
  int value = 250;

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
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
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
                const SizedBox(
                  width: 40,
                ),
                _weather('assets/images/02d.png',
                    '${data[0].toStringAsFixed(1)} °C'),
                const SizedBox(
                  width: 20,
                ),
                _weather('assets/images/hum.png', '${data[4].toDouble()} %'),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width - 32,
              child: Wrap(
                spacing: 30,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  _item('D10', data[1].toDouble(), Colors.blue, 'μg/m3'),
                  _item('UV', data[2].toDouble(), Colors.blue, 'µW/cm²'),
                  _item(
                      'CO',
                      data[3].toDouble(),
                      TripleH.CO.initializeFromRange(value: 46000).color,
                      'ppm'),
                  Builder(
                    builder: (context) {

                      return _item(
                          'PM2.5',
                          data[5],
                          TripleH.PM10.initializeFromRange(value: 275).color,
                          'μg/m3');
                    }
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
          width: 360,
          decoration: BoxDecoration(
            color: TripleH.aqiDATN.initializeFromRange(range: value.toDouble()).color,
            boxShadow: [
              BoxShadow(
                offset: const Offset(3, 1),
                blurRadius: 10,
                color: TripleH.aqiDATN.initializeFromRange(range: value.toDouble()).color ??
                    Colors.white,
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Image(
                image: AssetImage(TripleH.aqiDATN
                    .initializeFromRange(range: value.toDouble())
                    .pathAvatar
                    .toString()),
                height: 120,
                width: 120,
              ),
              const SizedBox(
                width: 20,
              ),
              _value(),
              const SizedBox(
                width: 30,
              ),
              _status(condition)
            ],
          ),
        ),
      ],
    );
  }

  String getTime(var time) {
    final DateFormat formatter =
        DateFormat('dd/MM/yyyy, hh:mm:ss aa'); //your date format here
    var date = time.toDate();
    return formatter.format(date);
  }

  Text _status(TripleH.aqiDATN? conditionDATN) {
    return Text(

      TripleH.aqiDATN.initializeFromRange(range: value.toDouble()).state.getName,
      textAlign: TextAlign.center,
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

  Container _item(String element, double value, Color color, String unit) {
    var f = NumberFormat("###.#", "en_US");
    String valueString = f.format(value);
    return Container(
      width: 100,
      height: 250,
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
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(80 / 2)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    valueString,
                    style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _unit(unit),
            const SizedBox(
              height: 30,
            ),
            Text(
              element,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Container _unit(String unit) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: const Color(0xff635666),
          borderRadius: BorderRadius.circular(60 / 2)),
      child: Center(
        child: Text(
          unit,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
