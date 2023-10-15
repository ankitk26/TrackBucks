import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
// ignore: implementation_imports
import 'package:supabase/src/supabase_stream_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionService {
  final _supabase = Supabase.instance.client;

  SupabaseStreamBuilder get allTransactions => _supabase
      .from('transactions')
      .stream(primaryKey: ['upi_ref_id']).order('transaction_date',
          ascending: false);

  SupabaseStreamBuilder getTransactionsByUpi(String upiId) => _supabase
      .from('transactions')
      .stream(primaryKey: ['upi_ref_id'])
      .eq('receiver_upi', upiId)
      .order('transaction_date', ascending: false);

  PostgrestFilterBuilder getTransactionTotals() =>
      _supabase.rpc('get_transaction_totals');

  PostgrestFilterBuilder getGroupedTotals() =>
      _supabase.rpc('get_grouped_totals');

  PostgrestFilterBuilder getSearchResults(String searchText) => _supabase.rpc(
        'search_transactions',
        params: {
          'search_text': searchText,
        },
      );

  getTransactionsByMonth(int year, int month) {
    final firstDayOfMonth = DateTime(year, month);
    final lastDayOfMonth = DateTime(year, month + 1, 0);

    return _supabase
        .from('transactions')
        .select('*')
        .gte('transaction_date', firstDayOfMonth)
        .lte('transaction_date', lastDayOfMonth)
        .order('transaction_date', ascending: false);
  }

  Future<void> fetchNewTransactions() async {
    try {
      await http.post(
        Uri.parse("https://upi-transactions-api.vercel.app/new-transactions"),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  final transactionProvider = StreamProvider((ref) async* {
    yield TransactionService().allTransactions;
  });
}
