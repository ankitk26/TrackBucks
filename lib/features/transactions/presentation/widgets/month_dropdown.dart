import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackbucks/config/config.dart';
import 'package:trackbucks/features/transactions/presentation/providers/future_providers.dart';
import 'package:trackbucks/features/transactions/presentation/providers/state_providers.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/skeleton.dart';

class MonthDropdowns extends ConsumerWidget {
  const MonthDropdowns({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyTotals = ref.watch(monthlyTotalsProvider);
    final currentYear = ref.watch(currentYearProvider);

    return monthlyTotals.when(
      data: (data) {
        final years = data.map((e) => e.year).toSet().toList();

        return Row(
          children: [
            Expanded(
              child: DropdownButtonFormField(
                dropdownColor: Palette.background,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  filled: true,
                  fillColor: Palette.background,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Palette.foreground,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Palette.secondary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: currentYear,
                items: years
                    .map(
                      (year) => DropdownMenuItem(
                        value: year,
                        child: Text(year.toString()),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  final newYear = newValue as int;
                  ref.read(currentYearProvider.notifier).state = newYear;
                },
              ),
            ),
          ],
        );
      },
      error: (err, trace) => const Center(
        child: Text("Something went wrong"),
      ),
      loading: () => const Skeleton(height: 10),
    );
  }
}
