import 'package:blog_app/app/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final controller = Get.put(RegisterController());
  final _formkey = GlobalKey<FormState>();
  final nameCon = TextEditingController();
  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.1,
                    ),

                    //add profile
                    GetBuilder<RegisterController>(builder: (context) {
                      if (controller.photoProfile != null) {
                        return Stack(
                          children: [
                            SizedBox(
                              height: Get.height * 0.2,
                              width: Get.width * 0.3,
                              child: GestureDetector(
                                onTap: () {
                                  controller.selectPhotoProfile();

                                  //print("select photo profile");
                                },
                                child: CircleAvatar(
                                  backgroundImage:
                                  FileImage(controller.photoProfile!),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 30,
                              child: GestureDetector(
                                onTap: () {
                                  controller.selectPhotoProfile();

                                  // print("select photo profile");
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Icon(Icons.camera_alt),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Container(
                        height: Get.height * 0.2,
                        width: Get.width * 0.3,
                        child: GestureDetector(
                          onTap: () {
                            controller.selectPhotoProfile();

                            print("select photo profile");
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.camera_alt),
                          ),
                        ),
                      );
                    }),

                    //add button fiel email and password
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    TextFormField(
                      controller: nameCon,
                      decoration: InputDecoration(
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    TextFormField(
                      controller: emailCon,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!GetUtils.isEmail(value)) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    TextFormField(
                      obscureText:true,
                      controller: passwordCon,
                      decoration: InputDecoration(
                          hintText: "password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
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
                              String name = nameCon.text;
                              String email = emailCon.text;
                              String password = passwordCon.text;
                              if (_formkey.currentState!.validate()) {
                                controller.register(
                                  name: name,
                                  email: email,
                                  password: password,
                                  profile: controller.photoProfile,
                                );
                              }
                            },
                            child: Text("Register"),
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
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Login"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}