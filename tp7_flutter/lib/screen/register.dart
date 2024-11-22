import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../entities/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  User user = User(email: "", password: ""); // Fixed initialization

  String url = "http://10.0.2.2:8081/register";
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future save(User user) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      print('Register response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${response.body}')),
        );
      }
    } catch (e) {
      print('Registration error: $e');
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
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "Register",
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.w700,
                            fontSize: 50,
                            color: Colors.black45,
                          ),
                        ),
                        const Align(
                          alignment: Alignment.center,
                        ),
                        TextFormField(
                          controller: emailCtrl,
                          decoration: const InputDecoration(labelText: "Email"),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: passwordCtrl,
                          decoration: const InputDecoration(labelText: "Password"),
                          obscureText: true,
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          height: 90,
                          width: 90,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
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
