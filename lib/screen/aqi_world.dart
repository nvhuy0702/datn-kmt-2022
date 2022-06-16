import 'package:flutter/material.dart';
class AqiWorld extends StatelessWidget {
  const AqiWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 345,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
        Container(
          height: 300,
          width: 100,
          color: Colors.orange,
          child:   Column(
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage(
                      'assets/images/03d.png',
                    ),
                    height: 30,
                    width: 30,
                  ),
                  Text(
                      '32'
                  )
                ],
              )
            ],
          ),
        )
        ],
      ),
    );
  }
}
