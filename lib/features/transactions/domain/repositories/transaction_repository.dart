import 'package:trackbucks/features/transactions/domain/models/export.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getAllTransactions();
  Future<List<Transaction>> searchTransactions(String searchText);
  Future<List<Transaction>> getMonthlyTransactions(int year, int month);
  Future<List<MonthlyTotal>> getMonthlyTotals();
  Future<List<Transaction>> getTransactionsByUpi(String upiId);
  Future<List<PayeeTotal>> getInsights(int year);
  Future<void> loadNewTransactions();
}
