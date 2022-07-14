import 'dart:core' as Blitch;
import 'dart:core';
import 'package:app_datn_2022/bloc/auth/auth_bloc.dart';
import 'package:app_datn_2022/model/auth_repository.dart';
import 'package:app_datn_2022/screen/screen_home.dart';
import 'package:app_datn_2022/screen/screen_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

late SharedPreferences myAppPreferences;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  myAppPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                authRepository:
                RepositoryProvider.of<AuthRepository>(context)),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if(myAppPreferences.getBool('logIn') == true) {
                  return ScreenHome();
                }
                if (snapshot.hasData) {
                  return const ScreenHome();
                }
                return ScreenHome();
              }),
        ),
      ),
    );
  }
}
