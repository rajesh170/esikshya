class KhaltiTwoRequest {
  String publicKey;
  String token;
  String confirmationCode;
  String transactionPin;

  KhaltiTwoRequest(
      {required this.publicKey,
      required this.token,
      required this.confirmationCode,
      required this.transactionPin});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_key'] = publicKey;
    data['token'] = token;
    data['confirmation_code'] = confirmationCode;
    data['transaction_pin'] = transactionPin;
    return data;
  }
}
