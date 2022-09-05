class OpponentConnectedResponse {
  String? type;
  String? connectionStatus;
  String? opName;
  String? ownName;

  OpponentConnectedResponse(
      {this.type, this.connectionStatus, this.opName, this.ownName});

  OpponentConnectedResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    connectionStatus = json['connection_status'];
    opName = json['op_name'];
    ownName = json['own_name'];
  }

}
