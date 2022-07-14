import 'package:app_datn_2022/main.dart';
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
   String userProfile = '';
  @override
  void initState() {
    _isLogin = myAppPreferences.getBool('logIn') ?? false;
    super.initState();
  }

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
              onPressed: (){
                myAppPreferences.clear();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ScreenHome())
                );
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              )
          )
        ],
        leading: IconButton(
          onPressed: () {
            if(_isLogin) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ScreenHome())
              );
            }
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'abc',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
