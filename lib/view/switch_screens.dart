import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controller.dart';
import 'package:notes/view/authentication/wraper.dart';
import 'package:notes/view/home_screen.dart';
import 'package:notes/view/loding_screen.dart';

class SwitchScreens extends StatelessWidget {
  SwitchScreens({Key? key}) : super(key: key);

  final _controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return LodingScreen();
          } else {
            return Wraper();
          }
        });
  }
}
