import 'dart:convert';
import 'dart:ui';

import 'package:blog_app/app/models/user_res_model_model.dart';
import 'package:blog_app/app/service/API_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final _api = APIHelper();
  final box = GetStorage();
  bool isloading = false;
  UserProfileResModel currentUser = UserProfileResModel();
  @override
  void onInit() {
    getCurrentUser();
    super.onInit();
  }

 // var currentUser = {
  //"email": "molina@gmail.com",
  //"name": "molina",
 // "profile_url":
 //"https://wallpapercave.com/wp/wp7358135.jpg"
 // };
  void logout() async {
    try {

      final access_token = box.read("access_token");
      print("access token $access_token");
      final message = await _api.logout(accessToken: access_token);
      box.remove("access token");
      Get.snackbar("message", message,
          duration: Duration(milliseconds: 500), backgroundColor: Colors.grey);
      Get.offAllNamed("login");
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print(e);
    }
  }

  void getCurrentUser() async {
    try {
      isloading = true;
      update();
      final accessToken = box.read("access_token");
      final res = await _api.getCurrentUser(token: accessToken);
      currentUser = res;
      print("users ${jsonEncode(res)}");
      isloading = false;
      update();
    } catch (e) {
      isloading = false;
      update();
      Get.snackbar(
        "getCurrentUser",
        e.toString(),
      );
    }
  }
}
