import 'package:trackbucks/models/transaction.dart';

class TransactionListModel {
  final List<TransactionModel> transactions;

  TransactionListModel({required this.transactions});

  factory TransactionListModel.fromJson(List<dynamic> json) {
    return TransactionListModel(
        transactions: json.map((e) => TransactionModel.fromJson(e)).toList());
  }
}
