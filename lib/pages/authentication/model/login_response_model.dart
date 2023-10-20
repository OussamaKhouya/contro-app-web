class LoginResponseModel {
  String? token;
  String? name;
  String? username;
  String? role;

  LoginResponseModel({this.name, this.username, this.role,this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        name: json['name'],
        username: json['username'],
        role : json['role'],
        token : json['token']
    );
  }

}
