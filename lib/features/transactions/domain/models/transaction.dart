class Transaction {
  double amount;
  String payeeName;
  String receiverUpi;
  String senderUpi;
  DateTime transactionDate;
  String? upiRefId;
  int transactionKey;

  Transaction({
    required this.amount,
    required this.payeeName,
    required this.receiverUpi,
    required this.senderUpi,
    required this.transactionDate,
    this.upiRefId,
    required this.transactionKey,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json["amount"]?.toDouble(),
        payeeName: json["payee_name"],
        receiverUpi: json["receiver_upi"],
        senderUpi: json["sender_upi"],
        transactionDate: DateTime.parse(json["transaction_date"]),
        upiRefId: (json["upi_ref_id"] ?? "").toString(),
        transactionKey: json["transaction_key"],
      );
}
