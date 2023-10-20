import 'package:flutter_web/models/user.dart';
import 'package:flutter_web/pages/authentication/core/cache_manager.dart';
import 'package:flutter_web/pages/authentication/model/login_request_model.dart';
import 'package:flutter_web/pages/authentication/model/login_response_model.dart';
import 'package:get/get.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;
  Rx<LoginResponseModel>? currUser ;
  Rx<String?> token = "".obs;

  void logOut() {
    isLogged.value = false;
    this.token = "".obs;
    removeToken();
  }

  void login(LoginResponseModel user) async {
    print("u");
    print(user.name);
    print(user.username);
    print(user.role);
    isLogged.value = true;
    this.token = user.token.obs;
    this.currUser = user.obs;
    //Token is cached
    await saveToken(user.token);
    await saveUser(user);
  }

  void checkLoginStatus() {
    final token = getToken();
    this.token = token.obs;
    if (token != null) {
      isLogged.value = true;
      currUser = getUser().obs;
    }
  }
}
