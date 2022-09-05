class YourStatRequest {
  int? year;
  int? month;

  YourStatRequest({this.year, this.month});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    return data;
  }
}
