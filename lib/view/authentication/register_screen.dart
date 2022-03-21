import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/controller/controller.dart';
import 'package:notes/service/firebase_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FireBaseServide();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Register",
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 110,
                ),
                formTextField(
                    controller: email,
                    validator: MultiValidator([
                      requriedValidation,
                      EmailValidator(errorText: "Enter valid Email")
                    ]),
                    hintText: "Enter email address",
                    label: Text(
                      "Email",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                    keybordType: TextInputType.emailAddress,
                    predixIcon: const Icon(Icons.email)),
                const SizedBox(
                  height: 20,
                ),
                formTextField(
                    controller: password,
                    validator: requriedValidation,
                    hintText: "Enter password",
                    label: Text(
                      "password",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                    keybordType: TextInputType.visiblePassword,
                    predixIcon: const Icon(Icons.lock),
                    obscureText: true),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: 200,
                  height: 50,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 4, 92, 243),
                      blurRadius: 2,
                      spreadRadius: 3,
                    )
                  ]),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var response = await _auth.registerUser(
                              email.text, password.text);
                          print(response);
                        }
                      },
                      child: Text("Register")),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Get.find<Controller>().toggleScreen();
                    },
                    child: Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formTextField(
      {Widget? predixIcon,
      String? hintText,
      TextInputType? keybordType,
      TextEditingController? controller,
      bool obscureText = false,
      Widget? label,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          prefixIcon: predixIcon,
          hintText: hintText,
          label: label,
          filled: true,
          fillColor: Colors.grey[350],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      keyboardType: keybordType,
      obscureText: obscureText,
    );
  }

  final requriedValidation =
      RequiredValidator(errorText: "This field is requried");
}
