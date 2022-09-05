class SilentRefreshRequest {
  String refreshToken;

  SilentRefreshRequest({required this.refreshToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh_token'] = refreshToken;
    return data;
  }
}
