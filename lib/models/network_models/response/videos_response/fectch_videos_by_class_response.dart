class FetchVideoByClassResponse {
  int? id;
  int? grade;
  String? subject;
  String? topic;
  String? url;
  String? createdAt;

  FetchVideoByClassResponse(
      {this.id,
      this.grade,
      this.subject,
      this.topic,
      this.url,
      this.createdAt});

  FetchVideoByClassResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grade = json['grade'];
    subject = json['subject'];
    topic = json['topic'];
    url = json['url'];
    createdAt = json['created_at'];
  }
}
