import 'package:blog_app/app/screen/editprofile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          //Image.network("http://192.168.1.6:8000/users/1702467631.jpg"),
          SizedBox(
            height: Get.height * 0.05,
          ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
             /*GetBuilder(
               builder: (context) {
                 return Stack(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage:
                          NetworkImage(displayProfile +'/'+controller.currentUser.profileUrl!),
                    ),
                    Positioned(
                        bottom: 0.0,
                        right: 1.0,
                        child: GestureDetector(
                          onTap: () {
                            print("Press");
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          ),
                        ))
        ]
                  );
               }
             ),*/
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
                  radius: 60.0,
                  backgroundImage: NetworkImage(
                      "http://192.168.1.6:8000/users/1702467631.jpg"),
                ),
                Positioned(
                  bottom: 0.8,
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
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "molina",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
              Text(
                "molina@gmail.com",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),

              IconButton(
                  onPressed: () {
                    Get.to(() => EditProfileScreen());
                  },
                  icon: Icon(Icons.create))
            ],
          ),
        ],
      ),
      Divider(
        thickness: 1.0,
      ),
      Spacer(),
      ListTile(
        onTap: () {
          controller.logout();
        },
        leading: Icon(
          Icons.logout_outlined,
          color: Colors.red,
        ),
        title: Text(
          "Logout",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      )
    ]));
  }
}
