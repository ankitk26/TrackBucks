class MonthlySumModel {
  int year;
  int month;
  double totalAmount;

  MonthlySumModel({
    required this.year,
    required this.month,
    required this.totalAmount,
  });

  factory MonthlySumModel.fromJson(Map<String, dynamic> json) =>
      MonthlySumModel(
        year: json['year'],
        month: json['month'],
        totalAmount: json['total_amount']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "total_amount": totalAmount,
      };
}
