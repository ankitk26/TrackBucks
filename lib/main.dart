import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackbucks/data/constants.dart';
import 'package:trackbucks/firebase_options.dart';
import 'package:trackbucks/models/transaction.dart';
import 'package:trackbucks/services/transaction_service.dart';
import 'package:trackbucks/widgets/transaction_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: appBlack,
          appBarTheme: const AppBarTheme(
            backgroundColor: appBlack,
          ),
        ),
        home: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trackbucks"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
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
      body: StreamBuilder<QuerySnapshot>(
        stream: TransactionService()
            .transactionCollection
            .orderBy("TransactionDate", descending: true)
            .snapshots(),
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

          final transactions = data.docs.map((doc) =>
              TransactionModel.fromJson(doc.data()! as Map<String, dynamic>));

          if (transactions.isEmpty) {
            return const Center(
              child: Text("No transactions"),
            );
          }

          final currentMonth = DateTime.now().month;
          final currentYear = DateTime.now().year;

          final todayTotalTransactions = transactions
              .where((element) =>
                  element.transactionDate.toDate() == DateTime.now())
              .fold<double>(0,
                  (previousValue, element) => previousValue + element.amount);

          final monthTotalTransactions = transactions
              .where((element) =>
                  element.transactionDate.toDate().month == currentMonth &&
                  element.transactionDate.toDate().year == currentYear)
              .fold<double>(0,
                  (previousValue, element) => previousValue + element.amount);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: appBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Expenses Today",
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              NumberFormat.simpleCurrency(locale: "en_IN")
                                  .format(todayTotalTransactions),
                              // "₹${totalTransactions.toString()}",
                              style: const TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: appGreen,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: appPaper,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Expenses this Month",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          NumberFormat.simpleCurrency(locale: "en_IN")
                              .format(monthTotalTransactions),
                          // "₹${totalTransactions.toString()}",
                          style: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28.0),
                  const Text(
                    "Recent Transactions",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
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
      ),
    );
  }
}
