import 'package:blog_app/app/constant/constant.dart';
import 'package:blog_app/app/controller/post_controller.dart';
import 'package:blog_app/app/screen/select_photo_screen.dart';
import 'package:blog_app/app/screen/show_comment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';
import '../untils/untils.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});
  final controller = Get.find<PostController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GetBuilder<ProfileController>(builder: (con) {
              if (controller.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print("$displayProfile/${con.currentUser.profileUrl}");
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          "$displayProfile/${con.currentUser.profileUrl}"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "What's on your mind ?",
                            border: InputBorder.none),
                      ),
                    ))
                  ],
                ),
              );
            }),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.dialog(SelectPhotoScreen()).then((value) {
                        if (value != null) {
                          controller.getAllPosts();
                        }
                      });

                      //Get.to(() => SelectPhotoScreen(),
                      // transition: Transition.rightToLeft);
                    },
                    child: Container(
                      height: 40,
                      width: 100,
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
                            Icons.photo,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Photo",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.video_call,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Live",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                  )
                ],
              ),
            ),
            GetBuilder<PostController>(builder: (_) {
              if (controller.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (controller.posts.isEmpty) {
                return Center(
                  child: Text("No Post"),
                );
              }
              return Expanded(
                child: ListView.builder(
                    key: PageStorageKey('post'),
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      final post = controller.posts[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "${displayProfile}/${post.user!.profileUrl!}"),
                            ),
                            title: Text("${post.user!.name}"),
                            subtitle: Text(
                                "${DateUtil.convertToAgo(DateTime.parse(post.createdAt!))}"),
                            trailing: IconButton(
                              onPressed: () {
                                print("press");
                              },
                              icon: Icon(Icons.more_horiz_outlined),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Text(post.title!),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                               Image.network(
                                  "${displayPost}/${post.imageUrl}",
                                  width: double.infinity,
                                  height: 400,
                                  fit: BoxFit.cover,
                                ),

                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${post.likesCount} Like"),
                                InkWell(
                                    onTap: () {
                                      if (post.commentsCount == 0) return;
                                      controller.currentPostId = post.id;
                                      // Get.to(()=>ShowCommentScreen());
                                      controller.getComment(
                                          postId: post.id.toString());
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return ShowCommentScreen();
                                          });
                                    },
                                    child:
                                        Text("${post.commentsCount} Comment")),
                                Text("300 Share")
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    controller.liketoggle(
                                        postid: post.id.toString());
                                  },
                                  icon: post.liked!
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : Icon(Icons.favorite_border),
                                ),
                                IconButton(
                                    onPressed: () {
                                      controller.currentPostId = post.id;
                                      // Get.to(()=>ShowCommentScreen());
                                      controller.getComment(
                                          postId: post.id.toString());
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return ShowCommentScreen();
                                          });
                                    },
                                    icon: Icon(Icons.mode_comment_outlined)),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.share)),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
              );
            })
          ],
        ),
      ),
    );
  }
}
