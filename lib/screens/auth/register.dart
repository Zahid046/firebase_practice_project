import 'dart:developer';

import 'package:firebase_practice_project/services/auth.dart';
import 'package:firebase_practice_project/shared/constants.dart';
import 'package:firebase_practice_project/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key, this.toggleView});

  final Function? toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // textfield state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text(
          "Sign up to Coffee Cup",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: loading
            ? []
            : <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    widget.toggleView!();
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  label: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
      ),
      body: loading
          ? const Loading()
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val!.length < 6 ? 'Enter a password 6+ character long' : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[400],
                          minimumSize: const Size(100.0, 40.0),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            log(email.toString());
                            log(password.toString());
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _authService.registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Please supply valid data';
                                loading = false;
                              });
                            }
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        error,
                        style: const TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  )),
            ),
    );
  }
}
