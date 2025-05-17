class AuthModel {
  String? accessToken;
  String? refreshToken;

  AuthModel({this.accessToken, this.refreshToken});

  AuthModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
}