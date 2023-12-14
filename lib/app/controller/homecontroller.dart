import 'package:blog_app/app/controller/profile_controller.dart';
import 'package:blog_app/app/screen/homescreen.dart';
import 'package:blog_app/app/screen/login_screen.dart';
import 'package:blog_app/app/screen/post_screen.dart';
import 'package:blog_app/app/screen/profile_screen.dart';
import 'package:blog_app/app/screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class HomeController extends GetxController{
  int currentIndex = 0;
  final box = GetStorage();
  bool authenticated = false;
  @override
  void onInit(){
    isAuthenticated();
    super.onInit();
  }
  //check user is login or not
  void isAuthenticated(){
    final token = box.read("access_token");
    if(token != null){
      authenticated = true;
     //Get.offAllNamed("/login");
     //Get.offAll(LoginScreen());
    }
  }
  List <Widget> listScreen = [
    PostScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];
  void changeIndex(int index){
    currentIndex = index;
    update();
  }
}