import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/todo_service.dart';
import 'package:flutter_application_1/viewTask.dart';
import 'package:get_storage/get_storage.dart';

class AddTaskPage extends StatefulWidget {
  final int userId;

  AddTaskPage({required this.userId, super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      final formattedTime =
          "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00";
      setState(() {
        _timeController.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 77, 113, 255),
      appBar: AppBar(
        title: const Text(
          "Add Tasks",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 77, 113, 255),
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Center(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
              child: Card(
                color: Colors.grey[900],
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.all(screenWidth * 0.05), // Responsive padding
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Add your tasks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.06, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextField(
                        controller: _taskController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelText: 'Task',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      TextField(
                        controller: _dateController,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelText: 'Select Date',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      TextField(
                        controller: _timeController,
                        readOnly: true,
                        onTap: () => _selectTime(context),
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelText: 'Select Time',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Wrap(
                        spacing: screenWidth * 0.02, // Responsive spacing
                        runSpacing: screenHeight * 0.02,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              await addTask(
                                context: context,
                                userId: widget.userId,
                                task: _taskController.text,
                                date: _dateController.text,
                                time: _timeController.text,
                              );
                            },
                            icon: const Icon(Icons.add, color: Colors.black),
                            label: const Text(
                              'Add Task',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Viewtasks()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue[800],
                            ),
                            child: const Text(
                              'Continue',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
