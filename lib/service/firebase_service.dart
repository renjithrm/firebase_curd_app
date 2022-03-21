import 'package:firebase_auth/firebase_auth.dart';

class FireBaseServide {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registerUser(String email, String password) async {
    try {
      var userData = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = userData.user;
      return userData;
    } catch (e) {
      print(e);
    }
  }

  Future logIn(String email, String password) async {
    try {
      var response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(response);
    } catch (e) {
      print(e);
    }
  }

  Future logOut() async {
    await _auth.signOut();
  }
}
