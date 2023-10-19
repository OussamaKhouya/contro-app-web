import 'package:flutter_web/exception/app_exception.dart';

class UnknownException extends AppException {
  UnknownException([String? message]) : super(message, "Error: ");
}
