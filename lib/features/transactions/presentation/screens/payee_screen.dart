import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackbucks/config/config.dart';
import 'package:trackbucks/features/transactions/presentation/providers/future_providers.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/paper_card.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/transaction_list.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                upiId,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, widget) {
                  final payeeTransactions = ref.watch(payeeProvider(upiId));
                  return payeeTransactions.when(
                    data: (transactionList) {
                      if (transactionList.isEmpty) {
                        return const Center(
                          child: Text("No transactions"),
                        );
                      }

                      final totalTransactionAmount = transactionList.fold(
                        0.0,
                        (previousValue, element) =>
                            previousValue + element.amount,
                      );
                      final totalTransactions = transactionList.length;
                      // return Text("$totalTransactionAmount");

                      return Column(
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
                          TransactionList(
                            transactionList: transactionList.toList(),
                          ),
                        ],
                      );
                    },
                    error: (err, trace) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          "Some error occured. Try again later. $err",
                        ),
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
      ),
    );
  }
}
