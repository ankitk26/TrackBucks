import 'package:trackbucks/features/transactions/business/data_sources/export.dart';
import 'package:trackbucks/features/transactions/domain/models/export.dart';
import 'package:trackbucks/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final apiDataSource = ApiDataSourceImpl();
  final supabaseDataSource = SupabaseDataSourceImpl();

  @override
  Future<List<Transaction>> getAllTransactions() async {
    final results = await supabaseDataSource.getAllTransactions();
    return results.map((e) => Transaction.fromJson(e)).toList();
  }

  @override
  Future<List<Transaction>> getMonthlyTransactions(int year, int month) async {
    List<dynamic> results =
        await supabaseDataSource.getMonthlyTransactions(year, month);
    return results.map((e) => Transaction.fromJson(e)).toList();
  }

  @override
  Future<void> loadNewTransactions() async {
    await apiDataSource.loadNewTransactions();
  }

  @override
  Future<List<Transaction>> searchTransactions(String searchText) async {
    List<dynamic> searchResults =
        await supabaseDataSource.searchTransactions(searchText);
    return searchResults.map((e) => Transaction.fromJson(e)).toList();
  }

  @override
  Future<List<PayeeTotal>> getInsights(int year) async {
    List<dynamic> results = await supabaseDataSource.getInsights(year, 1);
    return results.map((e) => PayeeTotal.fromJson(e)).toList();
  }

  @override
  Future<List<Transaction>> getTransactionsByUpi(String upiId) async {
    List<dynamic> results =
        await supabaseDataSource.getTransactionsByUpi(upiId);
    return results.map((e) => Transaction.fromJson(e)).toList();
  }

  @override
  Future<List<MonthlyTotal>> getMonthlyTotals() async {
    List<dynamic> results = await supabaseDataSource.getMonthlyTotals();
    return results.map((e) => MonthlyTotal.fromJson(e)).toList();
  }
}
