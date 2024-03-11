class UserProfileResModel {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? profileUrl;
  String? createdAt;
  String? updatedAt;

  UserProfileResModel(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.profileUrl,
        this.createdAt,
        this.updatedAt});

  UserProfileResModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    profileUrl = json['profile_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['profile_url'] = this.profileUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}