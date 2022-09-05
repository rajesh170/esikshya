class NotificationResponse {
  int? id;
  int? userId;

  ///jasko ma notif. aako xa
  int? secondaryUserId; // notif. pathaune manxe
  String? title;
  String? type; // type of notification
  String? description;
  String? createdAt;

  NotificationResponse(
      {this.id,
      this.userId,
      this.secondaryUserId,
      this.title,
      this.type,
      this.description,
      this.createdAt});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    secondaryUserId = json['secondary_user_id'];
    title = json['title'];
    type = json['type'];
    description = json['description'];
    createdAt = json['created_at'];
  }
}
