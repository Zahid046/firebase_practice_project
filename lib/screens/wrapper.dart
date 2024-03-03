import 'dart:developer';

import 'package:firebase_practice_project/models/user.dart';
import 'package:firebase_practice_project/screens/auth/authenticate.dart';
import 'package:firebase_practice_project/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    log("User : $user");

    //return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
