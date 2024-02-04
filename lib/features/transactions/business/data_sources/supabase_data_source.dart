import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseDataSource {
  PostgrestTransformBuilder getAllTransactions();
  PostgrestFilterBuilder searchTransactions(String searchText);
  PostgrestTransformBuilder getMonthlyTransactions(int year, int month);
  PostgrestFilterBuilder getMonthlyTotals();
  PostgrestTransformBuilder getTransactionsByUpi(String upiId);
  PostgrestFilterBuilder getInsights(int year, int month);
}

class SupabaseDataSourceImpl implements SupabaseDataSource {
  final _supabase = Supabase.instance.client;

  @override
  PostgrestTransformBuilder getAllTransactions() {
    return _supabase.from('transactions').select('*').order(
          'transaction_date',
          ascending: false,
        );
  }

  @override
  PostgrestFilterBuilder getInsights(int year, int month) {
    return _supabase.rpc(
      'get_payee_insights',
      params: {
        'p_year': year,
      },
    );
  }

  @override
  PostgrestFilterBuilder getMonthlyTotals() {
    return _supabase.rpc('get_monthly_totals');
  }

  @override
  PostgrestTransformBuilder getTransactionsByUpi(String upiId) {
    return _supabase
        .from('transactions')
        .select('*')
        .eq('receiver_upi', upiId)
        .order('transaction_date', ascending: false);
  }

  @override
  PostgrestFilterBuilder searchTransactions(String searchText) {
    return _supabase.rpc(
      'search_transactions',
      params: {
        'search_text': searchText,
      },
    );
  }

  @override
  PostgrestTransformBuilder getMonthlyTransactions(int year, int month) {
    final firstDayOfMonth = DateTime(year, month);
    final lastDayOfMonth = DateTime(year, month + 1, 0);

    return _supabase
        .from('transactions')
        .select('*')
        .gte('transaction_date', firstDayOfMonth)
        .lte('transaction_date', lastDayOfMonth)
        .order('transaction_date', ascending: false);
  }
}
