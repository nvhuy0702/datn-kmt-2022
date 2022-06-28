import 'package:app_datn_2022/assets/colors.dart';
import 'package:flutter/material.dart';
class FieldPassword extends StatefulWidget {

  final String headerText;
  final String hintText;
  final TextEditingController textEditingController;
  const FieldPassword(
      {Key? key, required this.headerText, required this.hintText, required this.textEditingController})
      : super(key: key);

  @override
  State<FieldPassword> createState() => _FieldPasswordState();
}

class _FieldPasswordState extends State<FieldPassword> {
  bool _visible = true;

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
            widget.headerText,
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
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return value != null && value.length < 6
                    ? 'Mật khẩu không hợp lệ'
                    : null;
              },
              controller: widget.textEditingController,
              obscureText: _visible,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                      icon: Icon(
                          _visible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _visible = !_visible;
                        });
                      })),
            ),
          ),
        ),
      ],
    );
  }
}