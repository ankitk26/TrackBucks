import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trackbucks/config/config.dart';
import 'package:trackbucks/models/models.dart';
import 'package:trackbucks/providers/providers.dart';
import 'package:trackbucks/screens/home/widgets/search_transactions_delegate.dart';
import 'package:trackbucks/screens/screens.dart';
import 'package:trackbucks/services/services.dart';
import 'package:trackbucks/shared/widgets/widgets.dart';
import 'package:trackbucks/utils/utils.dart';

import 'widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const path = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawerKey = ref.watch(drawerKeyProvider);

    return Scaffold(
      key: drawerKey,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text("Trackbucks", style: TextStyle(fontSize: 16)),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchTransactionsDelegate(),
                );
              }),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            drawerKey.currentState!.openDrawer();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  backgroundColor: Palette.background,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  contentPadding: const EdgeInsets.all(40),
                  title: const Center(
                    child: Text(
                      "Loading new transactions",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          color: Palette.secondary,
                        )
                      ],
                    ),
                  ),
                )),
          );

          await TransactionService().fetchNewTransactions();
          ref.invalidate(monthlyTotalsProvider);
          if (context.mounted) {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          }
        },
        child: const Icon(Icons.refresh),
      ),
      body: Consumer(
        builder: (context, ref, widget) {
          final transactions = ref.watch(transactionsProvider);

          return transactions.when(
            error: (err, trace) => const Center(
              child: Text("Some error occured"),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(color: Palette.secondary),
            ),
            data: (data) {
              final transactionList =
                  data.map((e) => TransactionModel.fromJson(e)).toList();

              if (transactionList.isEmpty) {
                return const Center(
                  child: Text("No transactions"),
                );
              }

              final currentMonth = DateTime.now().month;
              final currentYear = DateTime.now().year;

              final todayTotalTransactionsAmount = transactionList
                  .where((element) =>
                      DateFormat("ddMMyyyy").format(element.transactionDate) ==
                      DateFormat("ddMMyyyy").format(DateTime.now()))
                  .fold<double>(
                      0,
                      (previousValue, element) =>
                          previousValue + element.amount);

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PaperCard(
                        title: "Your Expenses Today",
                        value: currencyFormatter(todayTotalTransactionsAmount),
                        cardColor: Palette.primary,
                        icon: CircleAvatar(
                          radius: 30,
                          backgroundColor: Palette.foreground,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AddTransactionScreen.path,
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Consumer(
                        builder: (context, ref, child) {
                          final monthlyData = ref.watch(monthlyTotalsProvider);

                          return monthlyData.maybeWhen(
                            data: (value) {
                              final data = value as List<dynamic>;
                              final monthlyTransactions = data
                                  .map((e) => MonthlySumModel.fromJson(e))
                                  .toList();

                              final currentMonthTotal =
                                  monthlyTransactions.where((e) =>
                                      e.year == currentYear &&
                                      e.month == currentMonth);

                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    MonthlyTransactionsScreen.path,
                                  );
                                },
                                child: PaperCard(
                                  title: "Your Expenses this Month",
                                  value: currencyFormatter(currentMonthTotal
                                          .isEmpty
                                      ? 0
                                      : currentMonthTotal.first.totalAmount),
                                ),
                              );
                            },
                            orElse: () => const SizedBox(height: 100),
                          );
                        },
                      ),
                      const SizedBox(height: 32.0),
                      const Text(
                        "Recent Transactions",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      const Divider(),
                      const SizedBox(height: 16.0),
                      TransactionList(transactionList: transactionList)
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
