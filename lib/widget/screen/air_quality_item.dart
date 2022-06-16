import 'package:app_datn_2022/bloc/bloc/value_bloc.dart';
import 'package:app_datn_2022/widget/custom_curve_painter.dart';
import 'package:flutter/material.dart';

class AirQualityItem extends StatefulWidget {
  final String location;
  final Color color;
  final String status;

  const AirQualityItem(
      {Key? key,
      required this.location,
      required this.color,
      required this.status})
      : super(key: key);

  @override
  State<AirQualityItem> createState() => _AirQualityItemState();
}

class _AirQualityItemState extends State<AirQualityItem> {
  ValueBloc valueBloc = ValueBloc();

  @override
  void initState() {
    valueBloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 345,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomShapeClass(),
            child: Container(
              color: widget.color,
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              _location(),
              const SizedBox(
                height: 15,
              ),
              _divider(),
              _status(),
              const SizedBox(
                height: 10,
              ),
              buildRow(),
              const SizedBox(
                height: 30,
              ),
              _divider()
            ],
          ),
        ],
      ),
    );
  }

  Widget buildRow() {
    return StreamBuilder(
        stream: valueBloc.streamValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();

          final data = snapshot.data as List<int>;
          return Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              _parameter(data[0].toString(), 'AQI', widget.color),
              const SizedBox(
                width: 20,
              ),
              _vertical(),
              const SizedBox(
                width: 20,
              ),
              _parameter(data[1].toString(), 'PM10', widget.color),
              const SizedBox(
                width: 20,
              ),
              _vertical(),
              const SizedBox(
                width: 20,
              ),
              _parameter(data[2].toString(), 'PM2.5', widget.color),
              const SizedBox(
                width: 20,
              ),
              _vertical(),
              const SizedBox(
                width: 20,
              ),
              _parameter(data[3].toString(), 'CO2', widget.color),
              const SizedBox(
                width: 20,
              ),
            ],
          );
        });
  }

  Container _vertical() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey,
    );
  }

  Column _parameter(String value, String element, Color? color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Text(
          element,
          style: TextStyle(color: color, fontSize: 17),
        )
      ],
    );
  }

  Column _status() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        const Text(
          'Không khí',
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.status,
          style: const TextStyle(
              fontSize: 29, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Container _divider() {
    return Container(
      width: 345,
      height: 1,
      color: Colors.grey,
    );
  }

  Row _location() {
    return Row(
      children: [
        const SizedBox(
          width: 150,
        ),
        Text(
          widget.location,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
        ),
      ],
    );
  }
}
