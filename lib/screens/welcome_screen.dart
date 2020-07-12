import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/signup_screen.dart';
import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoading = false;

  Future<void> _submit() async {
    try {
      setState(() {
        _isLoading = true;
      });
      dynamic homePage =
          await Provider.of<Auth>(context, listen: false).fetchData();
      if (homePage['message'] == 'success') {
        setState(() {
          _isLoading = false;
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(homePage)));
      } else {
        showErrorDialog('Please try later!!', context);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      const errorMessage = 'fail please try again later.';

      showErrorDialog(errorMessage, context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        Stack(children: <Widget>[
          Container(
              height: hight * 0.60,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('images/bg.png', fit: BoxFit.fill)),
          Padding(
            padding:
                EdgeInsets.only(top: hight * 0.55, left: (width / 2) - 42.5),
            child: Image.asset(
              'images/daarlogo.png',
              width: 85,
              height: 85,
            ),
          )
        ]),
        kSizedBoxHight30,
        Text(
          "مرحبا بك",
          style: TextStyle(
              color: Color(0xFF3C3C3C),
              fontWeight: FontWeight.bold,
              fontSize: 30),
          textDirection: TextDirection.rtl,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _submit();
              },
              child: _isLoading
                  ? Center(
                      child: kSpinkit,
                    )
                  : const Text(
                      ' كزائر',
                      style: TextStyle(
                          color: Color(0xFF3C3C3C),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                      textDirection: TextDirection.rtl,
                    ),
            ),
            kSizedBoxWidth4,
            Text(
              'تصفح التطبيق',
              style: TextStyle(color: Color(0xFF3C3C3C), fontSize: 20),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        SizedBox(
          height: hight * 0.04,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60,
              width: 160,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, SignUpScreen.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "انشاء الحساب",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        backgroundColor: Colors.white,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            kSizedBoxWidth15,
            Container(
              height: 60,
              width: 160,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, LoginScreen.routeName);
                },
                color: Colors.black,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                child: const Text(
                  "تسجيل الدخول",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    )));
  }
}
