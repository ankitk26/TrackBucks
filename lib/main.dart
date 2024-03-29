import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trackbucks/config/config.dart';
import 'package:trackbucks/features/auth/presentation/providers/stream_providers.dart';
import 'package:trackbucks/features/auth/presentation/screens/login_screen.dart';
import 'package:trackbucks/features/transactions/presentation/screens/export.dart';
import 'package:trackbucks/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_KEY'),
  );
  runApp(const ProviderScope(child: RootApp()));
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme.copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),
        home: Consumer(
          builder: (context, ref, child) {
            final authStateProviderValue = ref.watch(authStateProvider);

            return authStateProviderValue.when(
              data: (data) {
                if (data.session != null) {
                  return const HomeScreen();
                }

                return const LoginScreen();
              },
              error: (err, trace) => Text('$err'),
              loading: () => const LoginScreen(),
            );
          },
        ),
        onGenerateRoute: generateRoutes,
      ),
    );
  }
}
