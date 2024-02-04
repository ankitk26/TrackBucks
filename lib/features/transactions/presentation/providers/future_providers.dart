import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackbucks/features/transactions/business/repositories/transaction_repository_impl.dart';
import 'package:trackbucks/features/transactions/domain/models/export.dart';
import 'package:trackbucks/features/transactions/presentation/providers/state_providers.dart';

final transactionRepository = Provider((ref) => TransactionRepositoryImpl());

final allTransactionsProvider = FutureProvider((ref) {
  return ref.watch(transactionRepository).getAllTransactions();
});

final monthlyTotalsProvider = FutureProvider((ref) {
  return ref.watch(transactionRepository).getMonthlyTotals();
});

final monthlyTransactionsProvider = FutureProvider((ref) {
  final currentYear = ref.watch(currentYearProvider);
  final currentMonth = ref.watch(currentMonthProvider);
  return TransactionRepositoryImpl()
      .getMonthlyTransactions(currentYear, currentMonth);
});

final groupedTotalsProvider = FutureProvider((ref) {
  final currentYear = ref.watch(currentYearProvider);
  return ref.watch(transactionRepository).getInsights(currentYear);
});

final searchProvider =
    FutureProvider.family<List<Transaction>, String>((ref, query) {
  return ref.watch(transactionRepository).searchTransactions(query);
});

final payeeProvider = FutureProvider.family((ref, upiId) async {
  final transactionsByUpi = await ref
      .watch(transactionRepository)
      .getTransactionsByUpi(upiId.toString());
  return transactionsByUpi;
});
