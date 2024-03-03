import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice_project/screens/home/brew_list.dart';
import 'package:firebase_practice_project/services/auth.dart';
import 'package:firebase_practice_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text(
            "Coffee Cup",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
