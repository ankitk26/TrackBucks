import 'package:flutter/material.dart';
import 'package:trackbucks/screens/insights/insights_screen.dart';
import 'package:trackbucks/screens/screens.dart';

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
              Navigator.of(context)
                  .popAndPushNamed(MonthlyTransactionsScreen.path);
            },
          ),
          ListTile(
            title: const Text("Insights"),
            onTap: () {
              Navigator.of(context).popAndPushNamed(InsightsScreen.path);
            },
          ),
        ],
      ),
    );
  }
}
