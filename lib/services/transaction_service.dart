import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
// ignore: implementation_imports
import 'package:supabase/src/supabase_stream_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trackbucks/config/config.dart';

class TransactionService {
  final _supabase = Supabase.instance.client;

  SupabaseStreamBuilder get allTransactions => _supabase
          .from('transactions')
          .stream(primaryKey: ['transaction_key']).order(
        'transaction_date',
        ascending: false,
      );

  PostgrestTransformBuilder getTransactionsByUpi(
    String upiId,
    int year,
    int month,
  ) {
    try {
      // int lastday = DateTime(year, month == 12 ? 1 : month + 1, 0).day;

      final x = _supabase
          .from('transactions')
          .select('*')
          // .gte('transaction_date', '$year-$month-01 00:00:00+00')
          // .lte('transaction_date', '$year-$month-$lastday 23:59:59+00')
          // .stream(primaryKey: ['transaction_key'])
          .eq('receiver_upi', upiId)
          .order('transaction_date', ascending: false);

      return x;
    } catch (e) {
      return _supabase
          .from('transactions')
          .select('*')
          // .rangeAdjacent('transaction_date', '[2023-12-01, 2023-12-31]')
          // .stream(primaryKey: ['transaction_key'])
          .eq('receiver_upi', upiId)
          .order('transaction_date', ascending: false);
    }
  }

  PostgrestFilterBuilder getTransactionTotals() =>
      _supabase.rpc('get_monthly_totals');

  PostgrestFilterBuilder getGroupedTotals(int year, int month) => _supabase.rpc(
        'get_payee_insights',
        params: {
          'p_year': year,
        },
      );

  PostgrestFilterBuilder getSearchResults(String searchText) {
    return _supabase.rpc(
      'search_transactions',
      params: {
        'search_text': searchText,
      },
    );
  }

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
        Uri.parse(transactionsAPIEndpoint),
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
