class GameNotificationResponse {
  int? id;
  int? userId;
  int? oponentId;
  String? title;
  String? type;
  String? description;
  String? subject;
  String? status;
  int? grade;
  String? createdAt;

  GameNotificationResponse(
      {this.id,
      this.userId,
      this.oponentId,
      this.title,
      this.type,
      this.description,
      this.subject,
      this.status,
      this.grade,
      this.createdAt});

  GameNotificationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    oponentId = json['oponent_id'];
    title = json['title'];
    type = json['type'];
    description = json['description'];
    subject = json['subject'];
    status = json['status'];
    grade = json['grade'];
    createdAt = json['created_at'];
  }
}
