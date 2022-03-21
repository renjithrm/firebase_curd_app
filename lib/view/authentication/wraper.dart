import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controller.dart';
import 'package:notes/view/authentication/login_screen.dart';
import 'package:notes/view/authentication/register_screen.dart';

class Wraper extends StatelessWidget {
  Wraper({Key? key}) : super(key: key);
  final _controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
        id: "toggle",
        builder: (_) {
          return _controller.isLoginScreen ? LoginScreen() : RegisterScreen();
        });
  }
}
