import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final controller = Get.find<ProfileController>();

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
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                            "${controller.currentUser.profileUrl}"),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 1.0,
                        child: GestureDetector(
                          onTap: () {
                            print("pressed");
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                              onPressed: () {}, child: Text("Save"))),
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