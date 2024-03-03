import 'dart:developer';

import 'package:firebase_practice_project/services/auth.dart';
import 'package:firebase_practice_project/shared/constants.dart';
import 'package:firebase_practice_project/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, this.toggleView});

  final Function? toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
          "Sign in to Coffee Cup",
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
                    "Register",
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
                            dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Could not sign in with those credentials';
                                loading = false;
                              });
                            }
                          }
                        },
                        child: const Text(
                          "Sign in",
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
