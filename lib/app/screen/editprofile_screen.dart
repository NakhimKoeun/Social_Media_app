import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final controller = Get.find<ProfileController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GetBuilder<ProfileController>(builder: (context) {
              final TextEditingController _nameController =
                  TextEditingController();
              final TextEditingController _emailController =
                  TextEditingController();
              _nameController.text = controller.currentUser.name!;
              _emailController.text = controller.currentUser.email!;
              return Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  GetBuilder<ProfileController>(builder: (context) {
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
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  TextField(
                    controller: _emailController,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("Save"))),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
