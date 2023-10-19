import 'package:flutter_web/exception/app_exception.dart';

class NoConnectionException extends AppException {
  NoConnectionException() : super("Please check your internet connection");
}
