import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../service/API_helper.dart';

class RegisterController extends GetxController {
  final _imagePicker = ImagePicker();
  File? photoProfile;
  final _helper = APIHelper();

  //create a method select profile frome galary
  void selectPhotoProfile() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photoProfile = File(pickedFile.path);
      update();
      print("Photo Profile Selected");
    } else {
      print("No Photo selected");
    }
  }

  void register(
      {required String name,
      required String email,
      required password,
      required File? profile}) async {
    try {
      final res = await _helper.registerUser(
        name: name, email: email, profile: profile, password: password);
      Get.back(result: true);
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print(e);
    }
  }
}
