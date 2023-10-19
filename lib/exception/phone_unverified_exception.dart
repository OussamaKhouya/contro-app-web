import 'package:flutter_web/exception/app_exception.dart';

class PhoneUnverifiedException extends AppException {
  PhoneUnverifiedException([message]) : super(message, "About Phone Number: ");
}
