class PayeeTotal {
  String payeeName;
  String receiverUpi;
  double totalAmount;

  PayeeTotal({
    required this.payeeName,
    required this.receiverUpi,
    required this.totalAmount,
  });

  factory PayeeTotal.fromJson(Map<String, dynamic> json) => PayeeTotal(
        payeeName: json['payee_name'],
        receiverUpi: json['receiver_upi'],
        totalAmount: json['total_amount']?.toDouble(),
      );
}
