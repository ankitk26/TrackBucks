import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionService {
  final _transcations = FirebaseFirestore.instance.collection('transactions');

  CollectionReference<Map<String, dynamic>> get transactionCollection =>
      _transcations;
}
