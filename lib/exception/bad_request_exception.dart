import 'package:flutter_web/exception/app_exception.dart';

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}
