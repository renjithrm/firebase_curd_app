import 'package:get/get.dart';

class Controller extends GetxController {
  bool isLoginScreen = true;
  toggleScreen() {
    isLoginScreen = !isLoginScreen;
    update(["toggle"]);
  }
}
