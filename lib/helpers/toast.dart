import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
