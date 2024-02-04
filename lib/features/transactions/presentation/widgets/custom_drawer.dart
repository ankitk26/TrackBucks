import 'package:flutter/material.dart';
import 'package:trackbucks/features/auth/business/repositories/auth_repository_impl.dart';
import 'package:trackbucks/features/transactions/presentation/screens/insights_screen.dart';
import 'package:trackbucks/features/transactions/presentation/screens/monthly_transactions_scren.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const ListTile(
            title: Text("Ankit Kumar"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Monthly Expenses"),
            onTap: () {
              Navigator.of(context).popAndPushNamed(
                MonthlyTransactionsScreen.path,
              );
            },
          ),
          ListTile(
            title: const Text("Insights"),
            onTap: () {
              Navigator.of(context).popAndPushNamed(InsightsScreen.path);
            },
          ),
          ListTile(
            title: const Text("Log out"),
            onTap: () async {
              await AuthRepositoryImpl().logout();
            },
          ),
        ],
      ),
    );
  }
}
