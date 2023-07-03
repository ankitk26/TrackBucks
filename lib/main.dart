import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trackbucks/data/constants.dart';
import 'package:trackbucks/screens/add_transaction_screen.dart';
import 'package:trackbucks/screens/home_screen.dart';
import 'package:trackbucks/screens/monthly_transactions.dart';
import 'package:trackbucks/utils/generate_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_KEY'),
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
          textTheme: GoogleFonts.workSansTextTheme(ThemeData.dark().textTheme),
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
