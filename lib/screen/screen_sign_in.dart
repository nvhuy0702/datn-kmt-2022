import 'package:app_datn_2022/assets/colors.dart';
import 'package:app_datn_2022/bloc/auth/auth_bloc.dart';
import 'package:app_datn_2022/screen/control_device.dart';
import 'package:app_datn_2022/screen/screen_sign_up.dart';
import 'package:app_datn_2022/widget/field_account.dart';
import 'package:app_datn_2022/widget/field_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenSignIn extends StatefulWidget {
  const ScreenSignIn({Key? key}) : super(key: key);

  @override
  State<ScreenSignIn> createState() => _ScreenSignInState();
}

class _ScreenSignInState extends State<ScreenSignIn> {

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ControlDevice())
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        }, child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: secondaryColor,
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.10,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: whiteShade,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45))),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width * 0.8,
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * 0.09),
                                child: Center(
                                  child: Text(
                                      'Đăng nhập',
                                      style: GoogleFonts.pacifico(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 50,
                                          color: const Color(0xff42C2FF)
                                      )
                                  ),
                                ),
                              ),
                              FieldAccount(
                                headerText: "Tài khoản",
                                hintText: "Email",
                                textEditingController: _email,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FieldPassword(
                                headerText: "Mật khẩu",
                                hintText: "Mật khẩu",
                                textEditingController: _password,
                              ),
                              const SizedBox(height: 45,),
                              InkWell(
                                onTap: () {
                                  _authenticateWithEmailAndPassword(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  margin: const EdgeInsets.only(left: 20, right: 20),
                                  decoration: BoxDecoration(
                                      color: secondaryColor,
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      "Đăng nhập",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: whiteShade
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 60,),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * 0.149,
                                    top: MediaQuery.of(context).size.height * 0.05),
                                child: Text.rich(
                                  TextSpan(
                                      text: "Bạn chưa có tài khoản?  ",
                                      style: TextStyle(
                                          color: grayShade.withOpacity(0.8), fontSize: 16),
                                      children: [
                                        TextSpan(
                                            text: "Đăng ký",
                                            style: TextStyle(color: blue, fontSize: 16),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => const ScreenSignUp()));
                                              }),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          }
      ),
      ),
    );
  }
  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequest(_email.text, _password.text),
      );
    }
  }
}

