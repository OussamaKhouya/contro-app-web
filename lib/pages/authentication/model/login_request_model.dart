class LoginRequestModel {
  String? username;
  String? password;

  LoginRequestModel({this.username, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = username;
    data['password'] = password;
    data['device_name'] = 'web';
    return data;
  }
}
