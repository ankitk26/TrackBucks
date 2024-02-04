import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackbucks/config/config.dart';
import 'package:trackbucks/features/transactions/presentation/providers/future_providers.dart';
import 'package:trackbucks/features/transactions/presentation/providers/state_providers.dart';
import 'package:trackbucks/features/transactions/presentation/screens/payee_screen.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/month_dropdown.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/monthly_data_chart.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/paper_card.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/skeleton.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/transaction_item.dart';
import 'package:trackbucks/utils/utils.dart';

class MonthlyTransactionsScreen extends StatelessWidget {
  const MonthlyTransactionsScreen({super.key});

  static const path = '/monthly-transactions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Monthly Expenses", style: TextStyle(fontSize: 16)),
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
                    const MonthlyDataChart(),
                    const SizedBox(height: 24.0),
                    Consumer(
                      builder: (context, ref, child) {
                        final currentYear = ref.watch(currentYearProvider);
                        final currentMonth = ref.watch(currentMonthProvider);

                        final monthlyTotals = ref.watch(monthlyTotalsProvider);

                        return monthlyTotals.when(
                          data: (data) {
                            final currentMonthExpenses = data
                                .where(
                                  (element) =>
                                      element.year == currentYear &&
                                      element.month == currentMonth,
                                )
                                .toList();

                            if (currentMonthExpenses.isEmpty) {
                              return const SizedBox();
                            }

                            return PaperCard(
                              title: "Expenses this month",
                              value: currencyFormatter(
                                currentMonthExpenses[0].totalAmount,
                              ),
                            );
                          },
                          loading: () => Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Palette.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          error: (err, trace) => const Text("Error"),
                        );
                      },
                    ),
                    const SizedBox(height: 28.0),
                    const Text(
                      "All Transactions",
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
                        final monthTransactions =
                            ref.watch(monthlyTransactionsProvider);

                        return monthTransactions.when(
                          data: (transactions) {
                            return Column(
                              children: transactions
                                  .map(
                                    (transaction) => GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          PayeeScreen.path,
                                          arguments: transaction.receiverUpi,
                                        );
                                      },
                                      child: TransactionItem(
                                        transaction: transaction,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                          error: (err, trace) => const Text("error"),
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
