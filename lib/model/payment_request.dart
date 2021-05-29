class PaymentRequest {
  String amount;
  String intent;

  PaymentRequest(this.amount, this.intent);

  PaymentRequest.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    intent = json['intent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['intent'] = this.intent;
    return data;
  }
}
