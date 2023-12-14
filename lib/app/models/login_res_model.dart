class LoginResModel {
  String? acessToken;
  String? tokenType;
  User? user;
  int? expirsIn;
 String? profileurl;
  LoginResModel({this.acessToken, this.tokenType, this.user, this.expirsIn});

  LoginResModel.fromJson(Map<String, dynamic> json) {
    acessToken = json['acess_token'];
    tokenType = json['token_type'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    expirsIn = json['expirs_in'];
    profileurl = json['profile_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acess_token'] = this.acessToken;
    data['token_type'] = this.tokenType;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['expirs_in'] = this.expirsIn;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;

  User({this.id, this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}