import 'package:flutter/material.dart';
import 'package:flutter_application_1/addTask.dart';
import 'package:flutter_application_1/viewTask.dart';

class MyHomePage extends StatelessWidget {
  final int userId;

  const MyHomePage({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 77, 113, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add a task',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTaskPage(
                                userId: userId,
                              )),
                    );
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black45),
                  child: const Text(
                    "Add Task",
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBox(height: 30),
              const Text(
                'View tasks',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Viewtasks()));
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black45),
                  child: const Text(
                    "View Task",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
