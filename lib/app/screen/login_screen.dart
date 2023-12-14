import 'package:blog_app/app/controller/login_controller.dart';
import 'package:blog_app/app/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogingScreen extends StatelessWidget {
  LogingScreen({super.key});
  final _forkey = GlobalKey<FormState>();
  final emailCon = TextEditingController(text: "shank@gmail.com");
  final passwordCon = TextEditingController(text: "123123");
  final _cotroller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: _forkey,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Text(
                    'Please Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ),
                  //add button fiel email and password
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  TextFormField(
                    controller: emailCon,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Email is required";
                      }
                      if(!GetUtils.isEmail(value)){
                        return "Email is not valid";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  TextFormField(
                    controller: passwordCon,
                    validator: (value){
                      if(value!.isEmpty){
                        return "password required";
                      }
                      if(value.length < 6){
                        return "password is not valid";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  //add login button
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if(_forkey.currentState!.validate()){
                              print("login");
                              _cotroller.login(email: emailCon.text, password: passwordCon.text);
                            }
                          },
                          child: Text("Login"),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  //add divider
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      )),
                      Text("OR"),
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ))
                    ],
                  ),
                  //add register button
                  TextButton(
                    onPressed: () async{
                     final status = await Get.to(() => RegisterScreen());
                     if(status == true){
                       Get.snackbar("Success","Register Success");
                     }
                    },
                    child: Text("Register"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
