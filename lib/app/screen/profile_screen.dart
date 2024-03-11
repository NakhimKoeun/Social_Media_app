import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../controller/profile_controller.dart';
import 'editprofile_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: Get.height * 0.05,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<ProfileController>(builder: (context) {
              if (controller.isloading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print("$displayProfile/${controller.currentUser.profileUrl}");
              return Stack(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                        "$displayProfile/${controller.currentUser.profileUrl}"),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 1.0,
                    child: GestureDetector(
                      onTap: () {
                        print("pressed");
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),

            SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.currentUser.name}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blueGrey,
                  ),
                ),
                 Container(
                   margin: EdgeInsets.only(left: 30),
                   child: ElevatedButton(
                     child: Text("Edit profile",style: TextStyle(color: Colors.black),),
                      onPressed: () {
                     Get.to(
                         () => EditProfileScreen(),
                      );
                    },
                   ),
                 ),
              ],
            ),
          ],
        ),
        SizedBox(
         height: 20,
        ),
        // Divider(
        //   thickness: 1.0,
        // ),
        Spacer(),
        ListTile(
          onTap: () {
            controller.logout();
          },
          leading: Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: Text(
            "Logout",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ),
      ],
    ));
  }
}
