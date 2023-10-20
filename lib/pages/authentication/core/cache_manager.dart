import 'dart:convert';

import 'package:flutter_web/models/user.dart';
import 'package:flutter_web/pages/authentication/model/login_response_model.dart';
import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.token.toString(), token);
    return true;
  }

  Future<bool> saveUser(LoginResponseModel u) async {

    final box = GetStorage();
    Map<String, dynamic> user = {'name': u.name, 'username': u.username, 'role': u.role};
    await box.write(CacheManagerKey.user.toString(), jsonEncode(user));
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.token.toString());
  }

  LoginResponseModel getUser() {
    final box = GetStorage();
    Map<String,dynamic> userMap = jsonDecode(box.read(CacheManagerKey.user.toString())) as Map<String, dynamic>;
    LoginResponseModel user = LoginResponseModel.fromJson(userMap);
    return user;
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.token.toString());
  }

  Future<void> clearUser() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.user.toString());
  }
}

enum CacheManagerKey { token, user }
