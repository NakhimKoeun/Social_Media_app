import 'package:blog_app/app/controller/homecontroller.dart';
import 'package:blog_app/app/controller/post_controller.dart';
import 'package:blog_app/app/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controller/profile_controller.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
   final controller = Get.put(ProfileController());
   final postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A1"),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller){
          if(controller.authenticated == false){
            return LogingScreen();
          }
          return IndexedStack(
            index: controller.currentIndex,
            children: controller.listScreen,
          );
        },
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (controller) {
          return BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: (index){
              controller.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), label: "Add"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined), label: "Profile"),
            ],
          );
        }
      ),
    );
  }
}
