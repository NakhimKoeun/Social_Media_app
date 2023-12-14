import 'package:blog_app/app/controller/homecontroller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => HomeController());
  }
}