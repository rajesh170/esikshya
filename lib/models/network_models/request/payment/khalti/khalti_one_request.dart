class KhaltiOneRequest {
  String publicKey;
  String mobile;
  String transactionPin;
  int amount;
  String productIdentity;
  String productName;

  KhaltiOneRequest(
      {required this.publicKey,
      required this.mobile,
      required this.transactionPin,
      required this.amount,
      required this.productIdentity,
      required this.productName});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_key'] = publicKey;
    data['mobile'] = mobile;
    data['transaction_pin'] = transactionPin;
    data['amount'] = amount;
    data['product_identity'] = productIdentity;
    data['product_name'] = productName;
    return data;
  }
}
