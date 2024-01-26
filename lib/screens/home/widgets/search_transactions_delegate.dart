import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackbucks/config/config.dart';
import 'package:trackbucks/models/models.dart';
import 'package:trackbucks/providers/providers.dart';
import 'package:trackbucks/shared/widgets/widgets.dart';
import 'package:trackbucks/utils/utils.dart';

class SearchTransactionsDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: Palette.background,
      primaryColor: Palette.primary,
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: InputBorder.none,
        hintStyle: TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          ),
        ],
      );
    }
    return Consumer(
      builder: (context, ref, child) {
        final searchResults = ref.watch(searchProvider(query));

        return searchResults.when(
          data: (data) {
            final dataJson = data as List<dynamic>;

            if (dataJson.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text("No results found"),
                ),
              );
            }

            final transactionList =
                dataJson.map((e) => TransactionModel.fromJson(e)).toList();
            final totalTransactionAmount = transactionList.fold<double>(
              0,
              (previousValue, element) => previousValue + element.amount,
            );
            final totalTransactions = transactionList.length;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                    TransactionList(
                      transactionList: transactionList,
                      canTap: true,
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Palette.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Palette.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Palette.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          error: (err, trace) => Text(err.toString()),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Column();
  }
}
