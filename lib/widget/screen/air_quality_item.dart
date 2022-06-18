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
    return Column(
      children: [
        _header(widget.condition),
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            _weather('assets/images/02d.png', 30),
            const SizedBox(
              width: 20,
            ),
            _weather('assets/images/50d.png', 20),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        _parameter(),
      ],
    );
  }

  Container _weather(String image, double valueWeather) {
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
          Text('${valueWeather.toString()} °C')
        ],
      ),
    );
  }

  Widget _parameter() {
    return StreamBuilder(
      stream: valueBloc.streamValue,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        final data = snapshot.data as List<int>;
        return SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width - 32,
          child: Wrap(
            spacing: 30,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _item('T', data[0].toDouble()),
              _item('CO2', data[1].toDouble()),
              _item('UV', data[2].toDouble()),
              _item('CO', data[3].toDouble()),
              _item('H', data[4].toDouble()),
            ],
          ),
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
              const SizedBox(width: 30,),
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
      TripleH.aqiDATN.initializeFromRange(range: 50).state.getName,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
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

  Container _item(String element, double value) {
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
                  color: Colors.redAccent,
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

