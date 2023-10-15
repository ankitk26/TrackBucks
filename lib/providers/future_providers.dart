import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackbucks/providers/providers.dart';
import 'package:trackbucks/services/transaction_service.dart';

class YearAndMonth {
  int year, month;
  YearAndMonth({required this.month, required this.year});
}

final monthlyTotalsProvider =
    FutureProvider((ref) => TransactionService().getTransactionTotals());

final monthlyTransactionsProvider = FutureProvider((ref) {
  final currentYear = ref.watch(currentYearProvider);
  final currentMonth = ref.watch(currentMonthProvider);
  return TransactionService().getTransactionsByMonth(currentYear, currentMonth);
});

final groupedTotalsProvider = FutureProvider((ref) {
  return TransactionService().getGroupedTotals();
});

final searchProvider = FutureProvider.family<dynamic, String>((_, query) {
  return TransactionService().getSearchResults(query);
});
