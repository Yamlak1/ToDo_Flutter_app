import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'services/todo_service.dart'; // Import the file containing your fetchTasks function

class Viewtasks extends StatefulWidget {
  final box = GetStorage();
  Viewtasks({super.key});

  @override
  _ViewtasksState createState() => _ViewtasksState();
}

class _ViewtasksState extends State<Viewtasks> {
  List<Map<String, dynamic>> _tasks = []; // List to store fetched tasks
  bool _isLoading = true; // State to track loading

  @override
  void initState() {
    super.initState();
    _fetchTasks(); // Fetch tasks when the widget is initialized
  }

  Future<void> _fetchTasks() async {
    final userId = widget.box.read('userId');
    print('User ID on Home Page: $userId');

    try {
      final tasks = await fetchTasks(userId);
      setState(() {
        _tasks = tasks;
        _isLoading = false; // Set loading to false after fetching tasks
      });
    } catch (error) {
      print('Error fetching tasks: $error');
      setState(() {
        _isLoading = false; // Set loading to false even if there's an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 77, 113, 255),
      appBar: AppBar(
        title: const Text(
          'Task List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 77, 113, 255),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Center(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Card(
                color: Colors.grey[900],
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Your Tasks:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.06, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _isLoading
                          ? CircularProgressIndicator()
                          : _tasks.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount: _tasks.length,
                                    itemBuilder: (context, index) {
                                      final task = _tasks[index];
                                      final taskName = task['task'];
                                      final taskTime = task[
                                          'time']; // Assuming the field is named 'time'
                                      final taskDate = task[
                                          'date']; // Assuming the field is named 'date'
                                      return ListTile(
                                        title: Text(
                                          taskName,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          'Time for completion : $taskTime\nDate for completion: $taskDate',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Text(
                                  'No tasks available',
                                  style: TextStyle(color: Colors.white),
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
