import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackbucks/data/constants.dart';

class TransactionService {
  final _transcations = FirebaseFirestore.instance.collection('transactions');

  FirestoreSnapshots get allTransactions =>
      _transcations.orderBy("TransactionDate", descending: true).snapshots();

  FirestoreSnapshots transactionsByUpi(String upiId) => _transcations
      .where("ReceiverUPI", isEqualTo: upiId)
      .orderBy("TransactionDate", descending: true)
      .snapshots();

  FirestoreSnapshots transactionsByMonth(int month, int year) {
    final firstDayOfMonth = DateTime(year, month);
    final lastDayOfMonth = DateTime(year, month + 1, 0);

    print("$firstDayOfMonth $lastDayOfMonth");

    return _transcations
        .where("TransactionDate", isGreaterThanOrEqualTo: firstDayOfMonth)
        .where("TransactionDate", isLessThanOrEqualTo: lastDayOfMonth)
        .orderBy("TransactionDate", descending: true)
        .snapshots();
  }
}
