class GetFriendListResponse {
  int? id;
  String? name;

  GetFriendListResponse({this.id, this.name});

  GetFriendListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
