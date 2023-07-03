import 'package:flutter/material.dart';
import 'package:trackbucks/data/constants.dart';
import 'package:trackbucks/models/transaction_list.dart';
import 'package:trackbucks/screens/screens.dart';
import 'package:trackbucks/services/transaction_service.dart';
import 'package:trackbucks/utils/utils.dart';
import 'package:trackbucks/widgets/widgets.dart';

class MonthlyTransactionsExpenses extends StatefulWidget {
  const MonthlyTransactionsExpenses({super.key});

  static const path = '/monthly-transactions';

  @override
  State<MonthlyTransactionsExpenses> createState() =>
      _MonthlyTransactionsExpensesState();
}

class _MonthlyTransactionsExpensesState
    extends State<MonthlyTransactionsExpenses> {
  final years = ['2022', '2023'];
  String currentYear = '2023';
  int currentMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Monthly Expenses"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButton(
                      value: currentYear,
                      items: years
                          .map((year) => DropdownMenuItem(
                                value: year,
                                child: Text(year),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          currentYear = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButton(
                      value: currentMonth,
                      items: months
                          .map((month) => DropdownMenuItem(
                                value: month.monthNumber,
                                child: Text(month.monthName),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          currentMonth = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              FutureBuilder(
                future: TransactionService().transactionsByMonth(
                  currentMonth,
                  int.parse(currentYear),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Some error occured"),
                    );
                  }

                  final data = snapshot.data;
                  if (data == null) {
                    return const Center(
                      child: Text("Nothing to show"),
                    );
                  }

                  final transactions =
                      TransactionListModel.fromJson(data).transactions;

                  if (transactions.isEmpty) {
                    return const Center(
                      child: Text("No transactions"),
                    );
                  }

                  final monthTotalTransactionsAmount =
                      transactions.fold<double>(
                          0,
                          (previousValue, element) =>
                              previousValue + element.amount);

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16.0),
                        PaperCard(
                          title: "Expenses in Month",
                          value:
                              currencyFormatter(monthTotalTransactionsAmount),
                        ),
                        const SizedBox(height: 28.0),
                        const Text(
                          "All Transactions",
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PayeeScreen.path,
                                arguments: transaction.receiverUpi,
                              );
                            },
                            child: TransactionItem(transaction: transaction),
                          );
                        }).toList())
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
