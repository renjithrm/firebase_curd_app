import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/controller/controller.dart';
import 'package:notes/service/firebase_store_service.dart';

enum SelectedScreen {
  add,
  edit,
}

class AddScreen extends StatefulWidget {
  Enum enums;
  String? title;
  String? content;
  String? id;

  AddScreen({Key? key, required this.enums, this.title, this.content, this.id})
      : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  Widget div = const SizedBox(
    height: 10,
  );

  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();

  final _contentController = TextEditingController();
  final _fireData = FireDatabase();

  @override
  void initState() {
    if (widget.enums == SelectedScreen.edit) {
      _titleController.text = widget.title.toString();
      _contentController.text = widget.content.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      smallText("Titel"),
                      div,
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            hintText: "Add title.....",
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "**requried";
                          }
                        },
                      ),
                      div,
                      smallText("Content"),
                      div,
                      TextFormField(
                        controller: _contentController,
                        maxLines: 8,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Add Content.....",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "**requried";
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              div,
              div,
              div,
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (widget.enums == SelectedScreen.add) {
                                  await _fireData.addData(_titleController.text,
                                      _contentController.text);
                                  Get.find<Controller>().update(["home"]);
                                  Get.back();
                                } else {
                                  await _fireData.updateData(
                                      _titleController.text,
                                      _contentController.text,
                                      widget.id.toString());
                                  Get.find<Controller>().update(["home"]);
                                  Get.back();
                                }
                              } else {
                                debugPrint("not validate");
                              }
                            },
                            child: Text("Save"))),
                    Expanded(
                        child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Cancel")))
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget smallText(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
