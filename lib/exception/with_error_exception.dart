import 'package:flutter_web/exception/app_exception.dart';

class WithErrorException extends AppException {
  WithErrorException([message]) : super(message, "With Error: ");
}
