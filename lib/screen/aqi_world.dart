
import 'package:flutter/material.dart';

import '../data/model/countries.dart';
class AqiWorld extends StatelessWidget {
  const AqiWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Data>? data;
    return Container(
      height: 200,
      width: 345,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
        _aqi(),
          const SizedBox(width: 40,),
          Column(
            children: [
              _titleLocation(
                data,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10,),
                      const Text(
                        'Th 5',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange
                        ),
                        child: Row(
                          children: const [
                            SizedBox(width: 10,),
                            Text(
                              '101 - 150'
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Image(
                              image: AssetImage(
                                'assets/images/04d.png'
                              ),
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(width: 15,),
                          Column(
                            children: const [
                              Text(
                                '31',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20
                                ),
                              ),
                              Text(
                                '21',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),

        ],
      ),
    );
  }

  Widget _titleLocation(List<Data>? data) {
    return ListView.builder(
        itemCount: data?.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(height: 10,),
              Text(
                data?[index].country ?? '',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                'TP Hồ Chí Minh',
                style: TextStyle(
                  fontSize: 15,
                ),
              )
            ],
          );
        }
    );
  }

  Container _aqi() {
    return Container(
        height: 300,
        width: 150,
        color: Colors.greenAccent,
        child:   Column(
          children: const [
            SizedBox(height: 15,),
           Text(
             'Tốt',
             style: TextStyle(
               fontSize: 30,
               color: Color(0xff990000)
             ),
           ),
            Text(
              '84',
              style: TextStyle(
                  fontSize: 60,
                  color: Color(0xff990000)
              ),
            ),
            Text(
              'AQI Mỹ',
              style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff990000)
              ),
            )
          ],
        ),
      );
  }
}
