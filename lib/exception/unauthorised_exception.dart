import 'package:flutter_web/exception/app_exception.dart';

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}
