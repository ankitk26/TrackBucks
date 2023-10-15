import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackbucks/config/config.dart';
import 'package:trackbucks/models/models.dart';
import 'package:trackbucks/providers/providers.dart';
import 'package:trackbucks/shared/widgets/widgets.dart';
import 'package:trackbucks/utils/utils.dart';

class PayeeScreen extends StatelessWidget {
  final String upiId;
  const PayeeScreen({super.key, required this.upiId});

  static const path = '/payee-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Text(
              upiId,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            Consumer(
              builder: (context, ref, widget) {
                final payeeTransactions = ref.watch(payeeProvider(upiId));
                return payeeTransactions.when(
                  data: (data) {
                    final transactionList =
                        data.map((e) => TransactionModel.fromJson(e));

                    if (transactionList.isEmpty) {
                      return const Center(
                        child: Text("No transactions"),
                      );
                    }

                    final totalTransactionAmount = transactionList.fold<double>(
                      0,
                      (previousValue, element) =>
                          previousValue + element.amount,
                    );
                    final totalTransactions = transactionList.length;

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            PaperCard(
                              title: "Total Expenses",
                              value: currencyFormatter(totalTransactionAmount),
                              cardColor: Palette.primary,
                            ),
                            const SizedBox(height: 16.0),
                            PaperCard(
                              title: "Total Payments",
                              value: totalTransactions.toString(),
                            ),
                            const SizedBox(height: 16.0),
                            PaperCard(
                              title: "Average Expense",
                              value: currencyFormatter(
                                totalTransactionAmount / totalTransactions,
                              ),
                            ),
                            const SizedBox(height: 36.0),
                            const Text(
                              "Recent Transactions",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            const Divider(),
                            const SizedBox(height: 16.0),
                            Column(
                              children: transactionList.map((transaction) {
                                return TransactionItem(
                                  transaction: transaction,
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  error: (err, trace) => const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text("Some error occured. Try again later"),
                    ),
                  ),
                  loading: () => Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Palette.secondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
