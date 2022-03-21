import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/model/user_model.dart';

class FireDatabase {
  final _fireDataBase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _userModel = UserModel();

  Future addData(String title, String content) async {
    var user = _auth.currentUser;
    try {
      _fireDataBase
          .collection("user")
          .doc(user!.uid)
          .collection("data")
          .add({"title": title, "content": content});
    } catch (e) {
      print(e);
    }
  }

  Stream<List<UserModel>> getData() async* {
    var model = <UserModel>[];
    var user = _auth.currentUser;
    try {
      var response = await _fireDataBase
          .collection("user")
          .doc(user!.uid)
          .collection("data")
          .get();
      print(response);
      for (var i = 0; i < response.docs.length; i++) {
        model.add(
            _userModel.fromJson(response.docs[i].data(), response.docs[i].id));
      }
      yield model;
    } catch (e) {
      print(e);
    }
  }

  Future updateData(String title, String content, String id) async {
    var user = _auth.currentUser;
    try {
      await _fireDataBase
          .collection("user")
          .doc(user!.uid)
          .collection("data")
          .doc(id)
          .update({"title": title, "content": content});
    } catch (e) {
      print(e);
    }
  }

  Future delectData(String id) async {
    var user = _auth.currentUser;
    try {
      await _fireDataBase
          .collection("user")
          .doc(user!.uid)
          .collection("data")
          .doc(id)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
