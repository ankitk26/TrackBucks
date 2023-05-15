import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trackbucks/data/constants.dart';
import 'package:trackbucks/firebase_options.dart';
import 'package:trackbucks/screens/add_transaction_screen.dart';
import 'package:trackbucks/screens/home_screen.dart';
import 'package:trackbucks/screens/monthly_transactions.dart';
import 'package:trackbucks/utils/generate_routes.dart';

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
          drawerTheme: const DrawerThemeData(
            backgroundColor: appPaper,
          ),
          dividerColor: Colors.grey,
        ),
        home: const HomeScreen(),
        onGenerateRoute: generateRoutes,
        routes: {
          MonthlyTransactionsExpenses.path: (context) =>
              const MonthlyTransactionsExpenses(),
          AddTransactionScreen.path: (context) => const AddTransactionScreen(),
        },
      ),
    );
  }
}
