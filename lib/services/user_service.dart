import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<void> addUser({
  required BuildContext context,
  required String fullName,
  required String userName,
  required String email,
  required String phone,
  required String password,
}) async {
  if (fullName.isEmpty ||
      userName.isEmpty ||
      email.isEmpty ||
      phone.isEmpty ||
      password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Please fill in all fields"),
      backgroundColor: Colors.red,
    ));
    return;
  }
  final url = 'http://localhost:3000/user/createUser';
  final headers = {'Content-Type': 'application/json'};

  final body = jsonEncode({
    'fullName': fullName,
    'userName': userName,
    'email': email,
    'phone': phone,
    'password': password
  });
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registered Successfully'),
        ),
      );
    }
    Navigator.pushReplacementNamed(context, '/home');
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error Registering User: $error'),
      backgroundColor: Colors.red,
    ));
  }
}

Future<Map<String, dynamic>> fetchUser(String userName) async {
  try {
    final url = 'http://localhost:3000/user/getUser?userName=$userName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Decode the response body as a map
      final Map<String, dynamic> user = jsonDecode(response.body);
      return user;
    } else {
      throw Exception('Failed to load user');
    }
  } catch (error) {
    throw Exception('Error getting user: $error');
  }
}
