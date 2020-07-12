import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/login_form.dart';
import '../constants.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: hight * 0.45,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                height: hight * 0.4,
                color: Color.fromRGBO(0, 0, 0, 0.3),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      kSizedBoxHight40,
                      Image.asset(
                        'images/daarlogo.png',
                        height: 85,
                      ),
                      kSizedBoxHight20,
                      const Text(
                        'تسجيل الدخول',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF3F4F4),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'سجل دخول الآن للحصول على ميزات التطبيق',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFDCDEE0),
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: hight * 0.4,
            height: hight * 0.55,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 7,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 25),
                      child: LoginForm()),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
