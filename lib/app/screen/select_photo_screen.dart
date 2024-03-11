import 'package:blog_app/app/controller/post_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SelectPhotoScreen extends StatelessWidget {
   SelectPhotoScreen({super.key});
  final captionCotroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back)),
              Text(
                "Back",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(
                  onPressed: () {
                    if(captionCotroller.text.isEmpty){
                      Get.snackbar("Error", "Caption is empty");
                      return;
                    }
                    Get.find<PostController>().createPost(caption: captionCotroller.text);
                  },
                  child: Text(
                    "UPLOAD",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ))
            ],
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          SizedBox(
            height: 10,
          ),
          GetBuilder<PostController>(builder: (con) {
            if (con.photoPost == null) {
              return Container();
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: captionCotroller,
                    decoration: InputDecoration(
                      hintText: "Write a Caption...",
                      border: InputBorder.none,
                    )
                  ),
                ),
                Container(
                  height: Get.height * 0.5,
                  width: Get.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: FileImage(con.photoPost!),
                    fit: BoxFit.cover,
                  )),
                ),
              ],
            );
          }),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.find<PostController>().selectPostPhoto();
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Select Photo",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
