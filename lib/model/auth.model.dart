class Authentication {
  String? token;
  String? refreshToken;

  Authentication(this.token, this.refreshToken);

  Authentication.fromJson(Map<String, dynamic> json) {
    token = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.token;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}