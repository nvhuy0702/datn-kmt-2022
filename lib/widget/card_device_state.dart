import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDeviceState extends StatefulWidget {
  const CardDeviceState(
      {Key? key,
      required this.title,
      required this.pathIconOpen,
      required this.pathIconClose,
      required this.isOn,
      required this.onClick})
      : super(key: key);
  final String title, pathIconOpen, pathIconClose;
  final bool isOn;
  final Function(bool) onClick;

  @override
  State<CardDeviceState> createState() => _CardDeviceStateState();
}

class _CardDeviceStateState extends State<CardDeviceState> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    double spaceHeight = 40;
    return Card(
      child: SizedBox(
        height: height * .25,
        width: width * .4,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  widget.isOn == false
                      ? Image(
                          image: AssetImage(widget.pathIconClose),
                          height: 50,
                          width: 50,
                        )
                      : Image(
                          image: AssetImage(widget.pathIconOpen),
                          height: 50,
                          width: 50,
                        ),
                  FlutterSwitch(
                    showOnOff: true,
                    activeTextColor: Colors.white,
                    inactiveTextColor: Colors.white,
                    value: widget.isOn,
                    onToggle: widget.onClick,
                  ),
                ],
              ),
              SizedBox(height: spaceHeight),
              Text(
                widget.title,
                style: GoogleFonts.crimsonPro(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
