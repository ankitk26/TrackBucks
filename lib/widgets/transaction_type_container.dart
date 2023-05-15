import 'package:flutter/material.dart';
import 'package:trackbucks/data/constants.dart';

class TransactionTypeContainer extends StatelessWidget {
  const TransactionTypeContainer({
    super.key,
    required this.transactionType,
    required this.icon,
    required this.label,
    required this.selectedTransactionType,
  });

  final IconData icon;
  final String label;
  final TransactionType transactionType, selectedTransactionType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              selectedTransactionType == transactionType ? appGreen : appPaper,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selectedTransactionType == transactionType
                  ? Colors.black
                  : Colors.white,
            ),
            const SizedBox(width: 4.0),
            Text(
              label,
              style: TextStyle(
                color: selectedTransactionType == transactionType
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
