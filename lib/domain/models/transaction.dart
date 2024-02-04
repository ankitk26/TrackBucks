class TransactionModel {
  double amount;
  String payeeName;
  String receiverUpi;
  String senderUpi;
  DateTime transactionDate;
  String? upiRefId;
  int transactionKey;

  TransactionModel({
    required this.amount,
    required this.payeeName,
    required this.receiverUpi,
    required this.senderUpi,
    required this.transactionDate,
    this.upiRefId,
    required this.transactionKey,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        amount: json["amount"]?.toDouble(),
        payeeName: json["payee_name"],
        receiverUpi: json["receiver_upi"],
        senderUpi: json["sender_upi"],
        transactionDate: DateTime.parse(json["transaction_date"]),
        upiRefId: (json["upi_ref_id"] ?? "").toString(),
        transactionKey: json["transaction_key"],
      );
}
