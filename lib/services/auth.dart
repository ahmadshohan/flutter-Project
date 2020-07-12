import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future signup(String name, String email, String password,
      String passwordConfirmation) async {
    final url = 'https://experts-tr.com/api/auth/register';
    try {
      http.Response response = await http.post(url, body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation
      });
      return response.body;
    } catch (error) {
      throw error;
    }
  }

  Future login(String email, String password) async {
    final url = 'https://experts-tr.com/api/auth/login';
    try {
      http.Response response = await http.post(url, body: {
        'email': email,
        'password': password,
      });
      return response.body;
    } catch (error) {
      throw error;
    }
  }

  dynamic fetchData() async {
    final url = 'https://experts-tr.com/api/auth/home_page';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    notifyListeners();
    return extractedData;
  }
}
