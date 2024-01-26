import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackbucks/services/services.dart';

final transactionsProvider = StreamProvider((ref) {
  final transactions = TransactionService().allTransactions;
  return transactions;
});
