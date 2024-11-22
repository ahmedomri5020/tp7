import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../entities/user.dart';
import 'dashboard.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final String url = "http://10.0.2.2:8081/login";
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  Future<void> save(User user) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body raw: ${response.body}');
      print('Request body sent: ${json.encode(user.toJson())}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Decoded response: $responseData');

        // Check the actual response structure
        if (responseData != null && responseData['id'] != null) { // Adjust based on your backend response
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid credentials')),
          );
        }
      } else {
        throw Exception('Server returned ${response.statusCode}');
      }
    } catch (e) {
      print('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  height: 520.0,
                  width: 340.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.w700,
                            fontSize: 50,
                            color: Colors.black45,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailCtrl,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordCtrl,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Register()),
                              );
                            },
                            child: const Text(
                              "Don't have an Account?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 90,
                          width: 90,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(233, 65, 82, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                save(User(
                                  email: emailCtrl.text,
                                  password: passwordCtrl.text,
                                ));
                              }
                            },
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
