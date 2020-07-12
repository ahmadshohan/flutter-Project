import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/signup_screen.dart';
import 'package:provider/provider.dart';
import '../screens/home_screen.dart';
import '../services/auth.dart';
import '../constants.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  bool _isLoading = false;
  bool _isInit = true;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();
    try {
      setState(() {
        _isLoading = true;
      });
      dynamic response = await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData['password']);
      dynamic homePage =
          await Provider.of<Auth>(context, listen: false).fetchData();
      final data = jsonDecode(response);
      if (data['message'] == 'success') {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeScreen(homePage)));
      } else {
        showErrorDialog('user not found !!', context);
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
  void dispose() {
    super.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.end,
              focusNode: _emailFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              style: kTextStyleTextFormField,
              decoration: InputDecoration(
                  hintText: "البريد الالكتروني",
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 11),
                    child: Image.asset(
                      'images/message.png',
                      color: Color(0xFFBEBEBE),
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints.loose(Size(30, 30)),
                  hintStyle: kTextStyleHintFormField,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color(0xFFF5F5F5)),
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Invalid email!';
                }
                return null;
              },
              onSaved: (value) {
                _authData['email'] = value;
              },
            ),
            kSizedBoxHight10,
            TextFormField(
              keyboardType: TextInputType.number,
              obscureText: true,
              textAlign: TextAlign.end,
              focusNode: _passwordFocusNode,
              style: kTextStyleTextFormField,
              decoration: InputDecoration(
                  suffixIconConstraints: BoxConstraints.loose(Size(30, 30)),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 11),
                    child: Image.asset(
                      'images/lock.png',
                      color: Color(0xFFBEBEBE),
                    ),
                  ),
                  hintText: "كلمة المرور ",
                  hintStyle: kTextStyleHintFormField,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color(0xFFF5F5F5)),
              onFieldSubmitted: (_) {
                _submit();
              },
              validator: (value) {
                if (value.isEmpty || value.length < 5) {
                  return 'Password is too short!';
                }
                return null;
              },
              onSaved: (value) {
                _authData['password'] = value;
              },
            ),
            kSizedBoxHight10,
            Align(
              alignment: Alignment.centerRight,
              child: const Text(
                'هل نسيت كلمة المرور؟',
                style: const TextStyle(fontSize: 15, color: Color(0xFF878787)),
                textAlign: TextAlign.center,
              ),
            ),
            kSizedBoxHight15,
            Container(
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  textColor: Colors.white,
                  color: const Color(0xFF3C3C3C),
                  child: _isLoading
                      ? Center(
                          child: kSpinkit,
                        )
                      : const Text(
                          'تسجيل الدخول',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                  onPressed: _submit),
            ),
            kSizedBoxHight30,
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SignUpScreen.routeName);
                    },
                    child: const Text(
                      'سجل حساب الان  ',
                      style: const TextStyle(
                          color: Color(0xFF878787), fontSize: 15),
                    ),
                  ),
                  kSizedBoxHight30,
                  const Text(
                    '  ليس لديك حساب؟',
                    style: const TextStyle(
                        color: Color(
                          0xFFCCCCCC,
                        ),
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
