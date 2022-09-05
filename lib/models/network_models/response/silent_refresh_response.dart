class SilentRefreshResponse {
  String? accessToken;
  String? refreshToken;

  SilentRefreshResponse({this.accessToken, this.refreshToken});

  SilentRefreshResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
}
