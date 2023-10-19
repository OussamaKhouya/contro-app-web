import 'package:flutter_web/exception/app_exception.dart';

class TooManyRequestsException extends AppException {
  TooManyRequestsException([String? message]) : super(message, "Error: ");
}
