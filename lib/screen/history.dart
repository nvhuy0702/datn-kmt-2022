import 'package:app_datn_2022/main.dart';
import 'package:app_datn_2022/widget/aqi_history.dart';
import 'package:flutter/material.dart';
class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<double> data = [50,60,80,90];

  @override
  void initState() {
    SharePreferenceSingleton.initializePrefrerences();

    Future.delayed(const Duration(milliseconds: 1000)).then((value) {

      // SharePreferenceSingleton.insert([10,20,30,40]);
      SharePreferenceSingleton.removeAll();
      SharePreferenceSingleton.insert(data);
      print("hihihihi => ${SharePreferenceSingleton.histories()}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Lịch sử AQI',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){

              },
              icon: const Icon(
                Icons.delete,
                size: 34,
                color: Colors.black,
              )
          )
        ],
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:  ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 15,),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return AqiHistory(value: data[index]);
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

}
