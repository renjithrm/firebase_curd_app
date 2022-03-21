import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/controller/controller.dart';
import 'package:notes/model/user_model.dart';
import 'package:notes/service/firebase_store_service.dart';
import 'package:notes/view/add_screen.dart';

class Cards extends StatelessWidget {
  int index;
  List<UserModel>? data;
  Cards({Key? key, required this.data, required this.index}) : super(key: key);
  final _firebaseStore = FireDatabase();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black54,
            ),
          ),
          height: 300,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    text(data![index].title ?? ""),
                    const Spacer(),
                    IconButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddScreen(
                                    enums: SelectedScreen.edit,
                                    title: data![index].title ?? "",
                                    content: data![index].content ?? "",
                                    id: data![index].uid,
                                  )));
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () async {
                          await _firebaseStore
                              .delectData(data![index].uid.toString());
                          Get.find<Controller>().update(["home"]);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    top: BorderSide(color: Colors.black38),
                  )),
                  padding: EdgeInsets.all(7),
                  width: double.infinity,
                  child: text(
                    data![index].content ?? "",
                    4,
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget text(String text, [int? maxLine]) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: 17,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine,
    );
  }
}
