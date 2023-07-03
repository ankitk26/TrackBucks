class TransactionModel {
  double amount;
  String payeeName;
  String receiverUpi;
  String senderUpi;
  DateTime transactionDate;
  int upiRefId;

  TransactionModel({
    required this.amount,
    required this.payeeName,
    required this.receiverUpi,
    required this.senderUpi,
    required this.transactionDate,
    required this.upiRefId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        amount: json["amount"]?.toDouble(),
        payeeName: json["payee_name"],
        receiverUpi: json["receiver_upi"],
        senderUpi: json["sender_upi"],
        transactionDate: DateTime.parse(json["transaction_date"]),
        upiRefId: json["upi_ref_id"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "payee_name": payeeName,
        "receiver_upi": receiverUpi,
        "sender_upi": senderUpi,
        "transaction_date": transactionDate.toIso8601String(),
        "upi_ref_id": upiRefId,
      };
}
