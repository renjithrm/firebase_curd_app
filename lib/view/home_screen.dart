import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/controller/controller.dart';
import 'package:notes/model/user_model.dart';
import 'package:notes/service/firebase_service.dart';
import 'package:notes/service/firebase_store_service.dart';
import 'package:notes/view/add_screen.dart';
import 'package:notes/view/loding_screen.dart';
import 'package:notes/view/widgets/cards.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _auth = FireBaseServide();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tweet",
          style: GoogleFonts.rowdies(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await _auth.logOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: GetBuilder<Controller>(
          id: "home",
          builder: (_) {
            return StreamBuilder<List<UserModel>>(
                stream: FireDatabase().getData(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  return snapshot.hasData
                      ? ListView.separated(
                          itemBuilder: (context, index) {
                            return Cards(data: data, index: index);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: snapshot.data!.length)
                      : const LodingScreen();
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => AddScreen(
                    enums: SelectedScreen.add,
                  )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
