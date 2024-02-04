import 'package:flutter/material.dart';
import 'package:trackbucks/features/transactions/presentation/screens/insights_screen.dart';
import 'package:trackbucks/features/transactions/presentation/screens/monthly_transactions_scren.dart';
import 'package:trackbucks/features/transactions/presentation/screens/payee_screen.dart';

Route<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case PayeeScreen.path:
      final upiId = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => PayeeScreen(upiId: upiId));

    case InsightsScreen.path:
      return MaterialPageRoute(builder: (context) => const InsightsScreen());

    case MonthlyTransactionsScreen.path:
      return MaterialPageRoute(
        builder: (context) => const MonthlyTransactionsScreen(),
      );

    default:
      return null;
  }
}
