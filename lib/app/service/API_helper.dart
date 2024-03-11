import 'dart:io';
import 'package:blog_app/app/models/login_res_model.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../models/comment_res_model.dart';
import '../models/post_res_model.dart';
import '../models/user_res_model_model.dart';

class APIHelper {
  final box = GetStorage();
  final dio = Dio();
  final String _baseUrl = "http://192.168.0.185:8000/api";

  ///register helper
  Future<String> registerUser({
    required String name,
    required String email,
    required String password,
    File? profile,
  }) async {
    var _formData = FormData.fromMap({
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": password,
      "profile": await MultipartFile.fromFile(profile!.path),
    });
    final res = await dio.post(
      "$_baseUrl/auth/register",
      data: _formData,
      options: Options(headers: {
        "Accept": "application/json",
      }, followRedirects: false, validateStatus: (status) => status! <= 500),
    );
    if (res.statusCode == 200) {
      return "Register Success";
    } else {
      throw Exception("Register Fail");
    }
  }
////login helper
  Future<LoginResModel> login(
      {required String email, required String password}) async {
    try {
      final res = await dio.post(
        "$_baseUrl/auth/login",
        data: {"email": email, "password": password},
        options: Options(
            headers: {
              "Accept": "application/json",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      if (res.statusCode == 200) {
        return LoginResModel.fromJson(res.data);
      } else if (res.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Login Fail");
      }
    } catch (e) {
      throw Exception('Login Final :$e');
    }
  }

/////logout helper
  Future<String> logout({required String accessToken}) async {
    try {
      final res = await dio.post(
        "$_baseUrl/auth/logout",
        //queryParameters: {"access_token": "Bearer $accessToken"},
        options: Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $accessToken",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );

      if (res.statusCode == 200) {
        return "Success logout";
      } else if (res.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception(res.statusMessage);
      }
    } catch (e) {
      throw Exception("Failed To Logout:$e");
    }
  }

  Future<UserProfileResModel> getCurrentUser({required String token}) async {
    try {
      final res = await dio.get(
        "$_baseUrl/auth/me",
        options: Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      if (res.statusCode == 200) {
        return UserProfileResModel.fromJson(res.data);
      } else {
        throw Exception("Login Fail");
      }
    } catch (e) {
      throw Exception('Login Final :$e');
    }
  }

  Future<PostResModel> getAllPost({required String token}) async {
    try {
      final res = await dio.get(
        "$_baseUrl/posts",
        options: Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print("res $res");
      if (res.statusCode == 200) {
        return PostResModel.fromJson(res.data);
      } else {
        throw Exception("Login Fail");
      }
    } catch (e) {
      throw Exception('Login Final :$e');
    }
  }

  Future<bool> liketoggle(
      {required String token, required String postId}) async {
    try {
      final res = await dio.post(
        "$_baseUrl/togglelik/$postId",
        options: Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print("res $res");
      if (res.statusCode == 200) {
        return true;
      } else {
        throw Exception("Login Fail");
      }
    } catch (e) {
      throw Exception('Login Final :$e');
    }
  }

  Future<CommentResModel> getCommentByPost({required String postId}) async {
    try {
      final token = box.read("access_token");
      final res = await dio.get(
        "$_baseUrl/comments/$postId",
        options: Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print("res $res");
      if (res.statusCode == 200) {
        return CommentResModel.fromJson(res.data);
      } else {
        throw Exception("Fail To Get Comments ");
      }
    } catch (e) {
      throw Exception('Fail To Get Comments :$e');
    }
  }

  Future<String> comment(
      {required String postId, required String comment}) async {
    try {
      final token = box.read("access_token");
      final res = await dio.post(
        "$_baseUrl/comment/$postId",
        data: {"text": comment},
        options: Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print("res $res");
      if (res.statusCode == 200) {
        return "success comment";
      } else {
        throw Exception("Login Fail");
      }
    } catch (e) {
      throw Exception('Login Final :$e');
    }
  }

  Future<bool> deleteComment({required String cmtId}) async {
    try {
      final token = box.read("access_token");
      final res = await dio.delete("$_baseUrl/comment/$cmtId",
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer $token",
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      print("res $res");
      if (res.statusCode == 200) {
        return true;
      } else {
        throw Exception("Fail To Delete comment");
      }
    } catch (e) {
      throw Exception("Fail To Delete comment,$e");
    }
  }

  Future<String> createpost(
      {required String caption, required File photo}) async {
    try {
      final token = box.read("access_token");
      var _formData = FormData.fromMap({
        "title": caption,
        "photo": await MultipartFile.fromFile(photo.path,
            filename: photo.path
                .split("/")
                .last),
      });
      final res = await dio.post(
        "$_baseUrl/post",
        data: _formData,
        options: Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print("res $res");
      if (res.statusCode == 200) {
        return "Post created";
      } else {
        throw Exception("Login Fail");
      }
    } catch (e) {
      throw Exception('Login Final :$e');
    }
  }
  Future<UserProfileResModel> updateUserProfile({required UserProfileResModel user,  File? profile}) async {
    try {
      final token = box.read("access_token");
      print("token: $token");
      var _formData = FormData.fromMap({
        "name": user.name,
        "profile": profile != null
            ? await MultipartFile.fromFile(
          profile.path,
          filename: profile.path.split('/').last,
        )
            : null,
      });
      final response = await dio.post(
          "$_baseUrl/updateProfile",
        data: _formData,
        options: Options(
          validateStatus: (status) => status! < 500,
          followRedirects: false,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      if (response.statusCode == 200) {
        // print("response.data: ${response.data}");
        return response.data['user'] != null
            ? UserProfileResModel.fromJson(response.data['user'])
            : UserProfileResModel();
      }
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: response.data['message'],
        message: response.data['message'],
        response: response,
      );
    } on DioException catch (e) {
      // if status code is 500
      if (e.response?.statusCode == 500) {
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Internal Server Error',
          message: 'Internal Server Error',
          response: e.response,
        );
      }

      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: e.error,
        message: e.message,
        response: e.response,
      );
    }
  }

}
