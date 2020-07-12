import 'dart:convert';

import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../constants.dart';
import '../screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
    "passwordConfirmation": '',
  };
  var _isLoading = false;
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordConfirmationFocusNode = FocusNode();
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
      dynamic homePageData =
          await Provider.of<Auth>(context, listen: false).fetchData();
      dynamic response = await Provider.of<Auth>(context, listen: false).signup(
          _authData['name'],
          _authData['email'],
          _authData['password'],
          _authData['passwordConfirmation']);
      print(jsonDecode(response));
      final data = jsonDecode(response);
      if (data['message'] == 'success') {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (ctx) => HomeScreen(homePageData)));
      } else {
        showErrorDialog('fail please try later', context);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      const errorMessage = 'Please try again later.';
      setState(() {
        _isLoading = false;
      });
      showErrorDialog(errorMessage, context);
    }
  }

  @override
  void initState() {
    super.initState();
    _authData = {
      'name': '',
      'email': '',
      'password': '',
      "passwordConfirmation": ''
    };
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _passwordConfirmationFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              textAlign: TextAlign.end,
              focusNode: _nameFocusNode,
              style: kTextStyleTextFormField,
              textInputAction: TextInputAction.next,
              decoration: kTextFormFieldNameDecoration,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_emailFocusNode);
              },
              onSaved: (value) {
                _authData['name'] = value;
              },
            ),
            kSizedBoxHight10,
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.end,
              focusNode: _emailFocusNode,
              textInputAction: TextInputAction.next,
              style: kTextStyleTextFormField,
              decoration: kTextFormFieldEmailDecoration,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
              },
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Invalid email!';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                _authData['email'] = value;
              },
            ),
            kSizedBoxHight10,
            TextFormField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.end,
              textInputAction: TextInputAction.next,
              style: kTextStyleTextFormField,
              focusNode: _phoneNumberFocusNode,
              decoration: kTextFormFieldPhoneNumberDecoration,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
            ),
            kSizedBoxHight10,
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.end,
              textInputAction: TextInputAction.next,
              focusNode: _passwordFocusNode,
              style: kTextStyleTextFormField,
              controller: _passwordController,
              decoration: kTextFormFieldPasswordDecoration,
              onFieldSubmitted: (_) {
                FocusScope.of(context)
                    .requestFocus(_passwordConfirmationFocusNode);
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
            TextFormField(
              keyboardType: TextInputType.number,
              obscureText: true,
              textInputAction: TextInputAction.done,
              focusNode: _passwordConfirmationFocusNode,
              textAlign: TextAlign.end,
              style: kTextStyleTextFormField,
              decoration: kTextFormFieldPasswordConfirmationDecoration,
              onFieldSubmitted: (_) {
                _submit();
              },
              validator: (value) {
                if (value != _passwordController.text) {
                  return 'Passwords do not match!';
                }
                return null;
              },
              onSaved: (value) {
                _authData['passwordConfirmation'] = value;
              },
            ),
            kSizedBoxHight10,
            Container(
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  textColor: Colors.white,
                  color: Color(0xFF3C3C3C),
                  child: _isLoading
                      ? Center(
                          child: kSpinkit,
                        )
                      : const Text(
                          'أنشئ حساب',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                  onPressed: _submit),
            ),
            kSizedBoxHight20,
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: const Text(
                      'سجل دخول الان  ',
                      style: const TextStyle(
                          color: Color(0xFF878787), fontSize: 15),
                    ),
                  ),
                  kSizedBoxHight10,
                  Text(
                    'لديك حساب؟ ',
                    style: kTextStyle,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
