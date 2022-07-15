import 'package:app_datn_2022/main.dart';
import 'package:app_datn_2022/screen/control_device.dart';
import 'package:app_datn_2022/screen/screen_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenInfoAccount extends StatefulWidget {
  const ScreenInfoAccount({Key? key}) : super(key: key);

  @override
  State<ScreenInfoAccount> createState() => _ScreenInfoAccountState();
}

class _ScreenInfoAccountState extends State<ScreenInfoAccount> {
  bool _isLogin = false;
  @override
  void initState() {
    _isLogin = myAppPreferences.getBool('logIn') ?? false;
    super.initState();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Thông tin tài khoản',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                myAppPreferences.clear();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const ScreenHome()));
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ))
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            RichText(
              text: TextSpan(
                text: 'Email đang được sử dụng: ',
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: '\n${auth.currentUser?.email}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontSize: 20
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
