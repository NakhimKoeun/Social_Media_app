import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:blog_app/app/models/post_res_model.dart';
import 'package:blog_app/app/service/API_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/comment_res_model.dart';

class PostController extends GetxController {
  final api = APIHelper();
  final box = GetStorage();
  final _imagePicker = ImagePicker();
  File? photoPost;

  PostResModel _posts = PostResModel();
  CommentResModel comments = CommentResModel();
  int? currentPostId;
  // get set post
  List<DataPost> get posts => _posts.data?.data! ?? [];
  bool commentLoading = false;

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  bool isLoading = false;
  void getAllPosts() async {
    try {
      isLoading = true;
      update();
      final token = box.read("access_token");
      final res = await api.getAllPost(token: token);
      print("All posts ${jsonEncode(res)}");
      _posts = res;
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar("getAllPost", toString());
    }
  }

  void liketoggle({required String postid}) async {
    try {
      isLoading = true;
      update();
      final token = box.read("access_token");
      final res = await api.liketoggle(token: token, postId: postid);
      print("All Toggle ${jsonEncode(res)}");
      getAllPosts();
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar("like Toggle", toString());
    }
  }

  void getComment({required String postId}) async {
    try {
      isLoading = true;
      update(['comment']);
      final res = await api.getCommentByPost(postId: postId);
      print("get Comment ${jsonEncode(res)}");
      comments = res;
      isLoading = false;
      update(['comment']);
    } catch (e) {
      isLoading = false;
      update(['comment']);
      Get.snackbar("getComment", e.toString());
    }
  }

  void comment({required String postId, required String comment}) async {
    try {
      final res = await api.comment(postId: postId, comment: comment);
      getComment(postId: postId);
      getAllPosts();
    } catch (e) {
      Get.snackbar("comment", e.toString());
    }
  }

  void deleteComment({required String cmtId, required int index}) async {
    try {
      final res = await api.deleteComment(cmtId: cmtId);
      if (res) {
        //delete by id
        comments.data!.remove(index);
        Get.snackbar(
          "Delete Comment",
          "Delete Comment Success",
        );
        update(['comment.id']);
      }

      getAllPosts();
    } catch (e) {
      Get.snackbar("Delete Comment", e.toString());
    }
  }
  void selectPostPhoto() async {
    final pickedFile =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photoPost = File(pickedFile.path);
      update();
      print("Photo Profile Selected");
    } else {
      print("No Photo selected");
    }
  }
  void createPost({required String caption})async{
    try{
      final res = await api.createpost(caption: caption, photo: photoPost!);
      print("create post ${jsonEncode(res)}");
      Get.back(result: true);
    }catch(e){
      Get.snackbar("ceatePost", e.toString());
    }
  }
}
