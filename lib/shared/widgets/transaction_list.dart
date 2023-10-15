import 'package:flutter/material.dart';
import 'package:trackbucks/models/models.dart';
import 'package:trackbucks/screens/screens.dart';
import 'package:trackbucks/shared/widgets/widgets.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactionList;
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
