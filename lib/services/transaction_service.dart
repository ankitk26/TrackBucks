import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionService {
  final _supabase = Supabase.instance.client;

  PostgrestTransformBuilder get allTransactions => _supabase
      .from('transactions')
      .select('*')
      .order('transaction_date', ascending: false);

  PostgrestTransformBuilder transactionsByUpi(String upiId) => _supabase
      .from('transactions')
      .select('*')
      .eq('receiver_upi', upiId)
      .order('transaction_date', ascending: false);

  PostgrestTransformBuilder transactionsByMonth(int month, int year) {
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
