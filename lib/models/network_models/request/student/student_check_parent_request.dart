class StudentCheckParentRequest {
  String randomKey;

  StudentCheckParentRequest({required this.randomKey});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['random_key'] = randomKey;
    return data;
  }
}
