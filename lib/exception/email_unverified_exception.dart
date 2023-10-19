import 'package:flutter_web/exception/app_exception.dart';

class EmailUnverifiedException extends AppException {
  EmailUnverifiedException([message]) : super(message, "With Error: ");
}
