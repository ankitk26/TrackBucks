import 'package:flutter/material.dart';
import 'package:trackbucks/data/constants.dart';
import 'package:trackbucks/models/transaction.dart';
import 'package:trackbucks/services/transaction_service.dart';
import 'package:trackbucks/utils/utils.dart';
import 'package:trackbucks/widgets/widgets.dart';

class PayeeScreen extends StatelessWidget {
  final String upiId;
  const PayeeScreen({super.key, required this.upiId});

  static const path = '/payee-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              upiId,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            StreamBuilder(
              stream: TransactionService().transactionsByUpi(upiId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Some error occured. Try again later"),
                  );
                }

                final data = snapshot.data;
                if (data == null) {
                  return const Center(
                    child: Text("Nothing to show"),
                  );
                }

                final transactions = data.docs
                    .map((doc) => TransactionModel.fromJson(doc.data()));

                if (transactions.isEmpty) {
                  return const Center(
                    child: Text("No transactions"),
                  );
                }

                final totalTransactionAmount = transactions.fold<double>(0,
                    (previousValue, element) => previousValue + element.amount);
                final totalTransactions = transactions.length;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PaperCard(
                          title: "Total Expenses",
                          value: currencyFormatter(totalTransactionAmount),
                          cardColor: appBlue,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: PaperCard(
                                title: "Total Payments",
                                value: totalTransactions.toString(),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: PaperCard(
                                title: "Average Expense",
                                value: currencyFormatter(
                                    totalTransactionAmount / totalTransactions),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28.0),
                        const Text(
                          "Recent Transactions",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        // const SizedBox(height: 8.0),
                        Divider(
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16.0),
                        Column(
                            children: transactions.map((transaction) {
                          return TransactionItem(transaction: transaction);
                        }).toList())
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
