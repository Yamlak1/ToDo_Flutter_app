import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<void> addTask({
  required BuildContext context,
  required int userId,
  required String task,
  required String date,
  required String time,
}) async {
  if (task.isEmpty || date.isEmpty || time.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please fill in all fields'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  final url =
      'http://localhost:3000/todo/createTask'; // Replace with your Node.js server URL
  final headers = {'Content-Type': 'application/json'};

  final body = jsonEncode({
    'userId': userId,
    'task': task,
    'date': date,
    'time': time,
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
        SnackBar(
          content: Text('Task added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Failed to add task. Status code: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error adding task: $error'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> fetchTasks(int userId) async {
  final url = 'http://localhost:3000/todo/getTask?userId=$userId';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((task) => task as Map<String, dynamic>).toList();
  } else {
    throw Exception('Error getting tasks: ${response.reasonPhrase}');
  }
}
