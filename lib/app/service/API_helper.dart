import 'dart:io';
import 'package:blog_app/app/models/login_res_model.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_res_model_model.dart';

class APIHelper {
  final dio = Dio();
  final String _baseUrl = "http://192.168.1.6:8000/api";
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
      } else if(res.statusCode == 401){
        throw Exception("Unauthorized");
      }
      else {
        throw Exception(res.statusMessage);
      }
    } catch (e) {
      throw Exception("Failed To Logout:$e");
    }
  }
  Future<UserProfileResModel> getCurrentUser({required String token})async{
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
  }


