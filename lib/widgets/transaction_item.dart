import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackbucks/data/constants.dart';
import 'package:trackbucks/models/transaction.dart';
import 'package:trackbucks/utils/currency_formatter.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final amountPrefix = transaction.senderUpi == myUpi ? -1 : 1;
    final formattedAmount =
        currencyFormatter(transaction.amount * amountPrefix);

    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.payeeName,
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat("dd-MM-yyyy HH:mm")
                      .format(transaction.transactionDate.toDate()),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            formattedAmount,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
