import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web/constants/constants.dart';
import 'package:flutter_web/exception/invalid_input_exception.dart';
import 'package:flutter_web/exception/no_connection_exception.dart';
import 'package:flutter_web/exception/too_many_requests_exception.dart';
import 'package:flutter_web/exception/unauthorised_exception.dart';
import 'package:flutter_web/exception/unknown_exception.dart';
import 'package:flutter_web/exception/with_error_exception.dart';
import 'package:flutter_web/helpers/toast.dart';
import 'package:flutter_web/models/user.dart';
import 'package:flutter_web/models/ligne_c.dart';
import 'package:http/http.dart' as http;
import '../models/commande.dart';

class ApiService {
  late String token;
  bool showSpinner = false;
  late User currUser;
  var client = http.Client();

  // ApiService(this.token);

  final String baseurl = "http://192.168.1.100:4300/api";


  Future<List<Commande>> fetchCommands() async {

    token = "177|UxRdbsvHWMkEj6ZY6ZjYfhlKOuvfWkE7BWW1kTpn";
    http.Response response = await client.get(Uri.parse('$baseurl/commandes'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        });
    List commandes = jsonDecode(response.body);
    return commandes.map((commande) => Commande.fromJson(commande)).toList();
  }


  Future<Commande> unlockCommande(Commande cmd) async{
    String uri = '$baseurl/commandes/${cmd.numpiece}';
    token = "177|UxRdbsvHWMkEj6ZY6ZjYfhlKOuvfWkE7BWW1kTpn";

    http.Response response;

    try {
       response = await client.put(Uri.parse(uri),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
          body: jsonEncode({
            'ver' : 0,
          })
      );
       print(response.statusCode);
      if (response.statusCode != 200) {
        await _handleOtherCases(response);
      }
    } on SocketException {
      ToastUtil.show("Please check your internet connection");
      throw NoConnectionException();
    } catch (e) {
      throw e;
    }

    return Commande.fromJson(jsonDecode(response.body));
  }

  Future<void> _handleOtherCases(http.Response response,) async {
      await _handleOtherStatusCodes(response);
      debugPrint(response.body);
    }

  Future<void> _handleOtherStatusCodes(http.Response response) async {
    String errorMessage = kDefaultString;
    List<String> errorMessages = [];

    Map<String, dynamic> bodyObject = convert.jsonDecode(response.body);

    if (bodyObject.containsKey(kKeyData)) {
      Map<String, dynamic> dataObject = bodyObject[kKeyData];

      if (dataObject.containsKey(kKeyJsonObject)) {
        Map<String, dynamic> errorJsonObject = dataObject[kKeyJsonObject];

        errorJsonObject.forEach((key, value) {
          errorMessages.add(value);
        });
      }

      if (dataObject.containsKey(kKeyStringData)) {
        errorMessage = dataObject[kKeyStringData] as String;
      }
    }

    if (bodyObject.containsKey(kKeyMessage)) {
      errorMessage = bodyObject[kKeyMessage] as String;
    }

    if (errorMessages.isNotEmpty) {
      errorMessage = errorMessages.join(kNewLineString);
    }

    switch (response.statusCode) {
      case 401:
        throw UnauthorisedException(errorMessage);
      case 417:
        throw WithErrorException(errorMessage);
      case 422:
        throw InvalidInputException(errorMessage);
      case 429:
        throw TooManyRequestsException(errorMessage);
      case 500:
      default:
        throw UnknownException(errorMessage);
    }
  }


  Future<List<LigneC>> fetchLigneC(String numpiece) async {
    token = "177|UxRdbsvHWMkEj6ZY6ZjYfhlKOuvfWkE7BWW1kTpn";
    http.Response response = await http.post(Uri.parse('${baseurl}/ligne-commandes/search'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json', //important
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer $token'
            },
            body: jsonEncode({
              'numpiece': numpiece,
            })
        );
    if (response.statusCode == 200) {
      List ligneCmd = jsonDecode(response.body);
      if(ligneCmd.isEmpty){
        return [];
      }
      return ligneCmd.map((ligneC) => LigneC.fromJson(ligneC)).toList();
    } else {
      String errorMessage = 'no data found';
      throw Exception(errorMessage);
    }
  }

  Future<List<String>> getImagesUrl(String numpiece, String numero) async {
    token = "177|UxRdbsvHWMkEj6ZY6ZjYfhlKOuvfWkE7BWW1kTpn";
    http.Response response =
    await http.get(Uri.parse('$baseurl/file/check/$numpiece/$numero'), headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    List imageUrls = jsonDecode(response.body);
    print(imageUrls);

    return imageUrls.map((element) => element.toString()).toList();
  }

  Future<Map<String, dynamic>> register(String name, String username, String role,
      String password, String passworConfirm, String deviceName) async {
   String uri = '$baseurl/auth/register';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'username': username,
          'role': role,
          'password': password,
          'password_confirmation': passworConfirm,
          'device_name': deviceName,
        }));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      Map<String, dynamic> body = jsonDecode(response.body);
      print(body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      errors.forEach((key, value) {
        value.forEach((element) {
          errorMessage += element + '\n';
        });
      });
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> login(String username, String password, String deviceName) async {
    String uri = '$baseurl/auth/login';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
          'device_name': deviceName,
        }));


    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      errors.forEach((key, value) {
        value.forEach((element) {
          errorMessage += element + '\n';
        });
      });
      throw Exception(errorMessage);
    }

  }

}
