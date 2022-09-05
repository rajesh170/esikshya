class EsewaSdkRequestModel {
  String? number;
  String? token;
  String? trid;
  int? amount;
  List<int>? childId;
  bool? save;

  EsewaSdkRequestModel(
      {required this.number,
      required this.token,
      required this.trid,
      required this.amount,
      required this.childId,
      required this.save});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['token'] = token;
    data['trid'] = trid;
    data['amount'] = amount;
    data['childId'] = childId;
    data['save'] = save;
    return data;
  }
}
