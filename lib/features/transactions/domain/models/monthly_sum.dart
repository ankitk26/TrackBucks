class MonthlyTotal {
  int year;
  int month;
  double totalAmount;

  MonthlyTotal({
    required this.year,
    required this.month,
    required this.totalAmount,
  });

  factory MonthlyTotal.fromJson(Map<String, dynamic> json) => MonthlyTotal(
        year: json['year'],
        month: json['month'],
        totalAmount: json['total_amount']?.toDouble(),
      );
}
