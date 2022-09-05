class StudentRegisterRequest {
  String randomKey;
  String username;
  String password;

  StudentRegisterRequest({
    required this.randomKey,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['random_key'] = randomKey;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
