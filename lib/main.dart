import 'package:blog_app/app/binding/login_bindinh.dart';
import 'package:blog_app/app/screen/homescreen.dart';
import 'package:blog_app/app/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/binding/home_binding.dart';
import 'app/screen/login_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "home",
      //initialBinding: LoginBinding(),
      getPages: [
        GetPage(
        name: "/login",
           page: () => LogingScreen(),
            binding: LoginBinding()
        ),
        GetPage(name: "/register", page: () => RegisterScreen()),
        GetPage(
            name: "/home", page: () => HomeScreen(), binding: HomeBinding()),
      ],
    );
  }
}
