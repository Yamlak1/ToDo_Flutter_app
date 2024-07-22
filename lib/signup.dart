import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import './services/user_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  final _phoneRegex = RegExp(r'^(09|07)\d{8}$');

  String? _emailError;
  String? _phoneError;

  bool _isEmailValid(String email) {
    return _emailRegex.hasMatch(email);
  }

  bool _isPhoneValid(String phone) {
    return _phoneRegex.hasMatch(phone);
  }

  void _validateFields() {
    setState(() {
      _emailError =
          _isEmailValid(_emailController.text) ? null : 'Invalid email';
      _phoneError =
          _isPhoneValid(_phoneController.text) ? null : 'Invalid phone number';
    });
  }

  Future<void> _handleSignup() async {
    _validateFields(); // Validate fields before proceeding

    if (_fullNameController.text.isEmpty ||
        _userNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _emailError != null ||
        _phoneError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the errors and fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await addUser(
        context: context,
        fullName: _fullNameController.text,
        userName: _userNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing up: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 77, 113, 255),
      appBar: AppBar(
        title: const Text(
          "Sign up Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 77, 113, 255),
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
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
                      'Enter your credentials',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.06, // Responsive font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextField(
                      controller: _fullNameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    TextField(
                      controller: _userNameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (text) => _validateFields(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        errorText: _emailError,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextField(
                      controller: _phoneController,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (text) => _validateFields(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        labelText: 'Phone number',
                        labelStyle: TextStyle(color: Colors.white),
                        errorText: _phoneError,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    TextField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Wrap(
                      spacing: screenWidth * 0.02, // Responsive spacing
                      runSpacing: screenHeight * 0.02,
                      alignment: WrapAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _handleSignup,
                          icon:
                              const Icon(Icons.person_add, color: Colors.black),
                          label: const Text(
                            'Register',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text("Already have an account? Login")),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
