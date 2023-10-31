import 'package:flutter_web/models/cmd.dart';
import 'package:get/get.dart';

class CommandeController extends GetxController {

  static CommandeController instance = Get.find();
  var cmdList = <Cmd>[].obs;
  var selectedNumpiece = "".obs;
  var selectedNumero = "".obs;

  void setSelectedNumpiece(String s) {
    selectedNumpiece = s.obs;
  }
  void setSelectedNumero(String s) {
    selectedNumpiece = s.obs;
  }

}

