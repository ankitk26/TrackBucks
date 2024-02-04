import 'package:flutter/material.dart';
import 'package:trackbucks/features/transactions/domain/models/export.dart';
import 'package:trackbucks/features/transactions/presentation/screens/payee_screen.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final bool canTap;
  const TransactionList({
    super.key,
    required this.transactionList,
    this.canTap = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactionList.map((transaction) {
        return canTap
            ? GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    PayeeScreen.path,
                    arguments: transaction.receiverUpi,
                  );
                },
                child: TransactionItem(transaction: transaction),
              )
            : TransactionItem(transaction: transaction);
      }).toList(),
    );
  }
}
