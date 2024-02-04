class PayeeTotal {
  String payeeName;
  String receiverUpi;
  double totalAmount;
  int transactionsCount;

  PayeeTotal({
    required this.payeeName,
    required this.receiverUpi,
    required this.totalAmount,
    required this.transactionsCount,
  });

  factory PayeeTotal.fromJson(Map<String, dynamic> json) => PayeeTotal(
        payeeName: json['payee_name'],
        receiverUpi: json['receiver_upi'],
        totalAmount: json['total_amount']?.toDouble(),
        transactionsCount: json['transactions_count'],
      );
}
