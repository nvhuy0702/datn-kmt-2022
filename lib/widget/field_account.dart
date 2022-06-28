import 'package:flutter/material.dart';

import '../assets/colors.dart';
class FieldAccount extends StatelessWidget {
  final String headerText;
  final String hintText;
  final TextEditingController textEditingController;
  const FieldAccount({Key? key, required this.headerText, required this.hintText, required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            headerText,
            style: const TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: grayShade.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextFormField(
                controller: textEditingController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                ),
              ),
            ) //IntrinsicHeight
        ),
      ],
    );
  }
}
