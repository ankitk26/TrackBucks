import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trackbucks/config/config.dart';
import 'package:trackbucks/features/transactions/business/repositories/transaction_repository_impl.dart';
import 'package:trackbucks/features/transactions/presentation/providers/export.dart';
import 'package:trackbucks/features/transactions/presentation/screens/export.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/export.dart';
import 'package:trackbucks/utils/utils.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const path = '/';

  void loadNewTransactions(context, ref) async {
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
                  ),
                ],
              ),
            ),
          )),
    );

    await TransactionRepositoryImpl().loadNewTransactions();
    ref.invalidate(monthlyTotalsProvider);
    ref.invalidate(allTransactionsProvider);
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    }
  }

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
            },
          ),
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
          loadNewTransactions(context, ref);
        },
        child: const Icon(Icons.refresh),
      ),
      body: Consumer(
        builder: (context, ref, widget) {
          final transactions = ref.watch(allTransactionsProvider);

          return transactions.when(
            error: (err, trace) => Center(
              child: Text("$err"),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(color: Palette.secondary),
            ),
            data: (data) {
              if (data.isEmpty) {
                return const Center(
                  child: Text("No transactions"),
                );
              }

              final currentMonth = DateTime.now().month;
              final currentYear = DateTime.now().year;

              final currentDayTransactionsTotalAmount = data
                  .where(
                    (element) =>
                        DateFormat("ddMMyyyy")
                            .format(element.transactionDate) ==
                        DateFormat("ddMMyyyy").format(DateTime.now()),
                  )
                  .fold<double>(
                    0,
                    (previousValue, element) => previousValue + element.amount,
                  );

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PaperCard(
                        title: "Your Expenses Today",
                        value: currencyFormatter(
                          currentDayTransactionsTotalAmount,
                        ),
                        cardColor: Palette.primary,
                      ),
                      const SizedBox(height: 16.0),
                      Consumer(
                        builder: (context, ref, child) {
                          final monthlyData = ref.watch(monthlyTotalsProvider);

                          return monthlyData.maybeWhen(
                            data: (monthlyDataResult) {
                              final currentMonthTotal = monthlyDataResult.where(
                                (e) =>
                                    e.year == currentYear &&
                                    e.month == currentMonth,
                              );

                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    MonthlyTransactionsScreen.path,
                                  );
                                },
                                child: PaperCard(
                                  title: "Your Expenses this Month",
                                  value: currencyFormatter(
                                    currentMonthTotal.isEmpty
                                        ? 0
                                        : currentMonthTotal.first.totalAmount,
                                  ),
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
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 16.0),
                      TransactionList(
                        transactionList: data,
                        canTap: true,
                      ),
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
