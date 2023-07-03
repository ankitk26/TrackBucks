import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackbucks/data/constants.dart';
import 'package:trackbucks/models/transaction_list.dart';
import 'package:trackbucks/screens/screens.dart';
import 'package:trackbucks/services/transaction_service.dart';
import 'package:trackbucks/utils/currency_formatter.dart';
import 'package:trackbucks/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const path = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text("Monthly Expenses"),
              onTap: () {
                Navigator.of(context)
                    .popAndPushNamed(MonthlyTransactionsExpenses.path);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text("Insights"),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("TrackBucks"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 1000),
        opacity: 1,
        child: FloatingActionButton(
          backgroundColor: appGreen,
          child: const Icon(Icons.arrow_upward),
          onPressed: () {},
        ),
      ),
      body: FutureBuilder(
        future: TransactionService().allTransactions,
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
              TransactionListModel.fromJson(snapshot.data).transactions;

          if (transactions.isEmpty) {
            return const Center(
              child: Text("No transactions"),
            );
          }

          final currentMonth = DateTime.now().month;
          final currentYear = DateTime.now().year;

          final todayTotalTransactionsAmount = transactions
              .where((element) =>
                  DateFormat("ddMMyyyy").format(element.transactionDate) ==
                  DateFormat("ddMMyyyy").format(DateTime.now()))
              .fold<double>(0,
                  (previousValue, element) => previousValue + element.amount);

          final monthTotalTransactionsAmount = transactions
              .where((element) =>
                  element.transactionDate.month == currentMonth &&
                  element.transactionDate.year == currentYear)
              .fold<double>(0,
                  (previousValue, element) => previousValue + element.amount);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PaperCard(
                    title: "Your Expenses Today",
                    value: currencyFormatter(todayTotalTransactionsAmount),
                    cardColor: appBlue,
                    icon: CircleAvatar(
                      radius: 30,
                      backgroundColor: appGreen,
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
                  PaperCard(
                    title: "Your Expenses this Month",
                    value: currencyFormatter(monthTotalTransactionsAmount),
                  ),
                  const SizedBox(height: 28.0),
                  const Text(
                    "Recent Transactions",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
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
            ),
          );
        },
      ),
    );
  }
}
