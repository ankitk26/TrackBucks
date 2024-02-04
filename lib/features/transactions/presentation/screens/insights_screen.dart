import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackbucks/features/transactions/presentation/providers/future_providers.dart';
import 'package:trackbucks/features/transactions/presentation/screens/payee_screen.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/month_dropdown.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/skeleton.dart';
import 'package:trackbucks/utils/utils.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  static const path = '/insights';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insights", style: TextStyle(fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const MonthDropdowns(),
              const SizedBox(height: 24.0),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16.0),
                    const Text(
                      "Transactions by Payee",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(),
                    const SizedBox(height: 16.0),
                    Consumer(
                      builder: (context, ref, child) {
                        final groupedTransactions =
                            ref.watch(groupedTotalsProvider);

                        return groupedTransactions.when(
                          data: (payeeTransactions) {
                            return Column(
                              children: payeeTransactions
                                  .map(
                                    (transaction) => GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          PayeeScreen.path,
                                          arguments: transaction.receiverUpi,
                                        );
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 28.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        transaction.payeeName,
                                                        style: const TextStyle(
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${transaction.transactionsCount} transaction${transaction.transactionsCount > 1 ? "s" : ""}",
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16.0),
                                            Text(
                                              currencyFormatter(
                                                transaction.totalAmount,
                                              ),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                          error: (err, trace) => Text(err.toString()),
                          loading: () => const Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Skeleton(height: 50),
                              SizedBox(height: 20),
                              Skeleton(height: 50),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
