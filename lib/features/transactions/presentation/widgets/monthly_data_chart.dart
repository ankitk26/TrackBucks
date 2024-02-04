import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackbucks/config/config.dart';
import 'package:trackbucks/features/transactions/presentation/providers/future_providers.dart';
import 'package:trackbucks/features/transactions/presentation/providers/state_providers.dart';
import 'package:trackbucks/features/transactions/presentation/widgets/skeleton.dart';

class MonthlyDataChart extends ConsumerWidget {
  const MonthlyDataChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentYear = ref.watch(currentYearProvider);
    final currentMonth = ref.watch(currentMonthProvider);

    final monthlyData = ref.watch(monthlyTotalsProvider);

    return monthlyData.when(
      data: (monthlyTransactions) {
        if (monthlyTransactions.isEmpty) {
          return const Center(
            child: Text("Nothing to show"),
          );
        }

        return AspectRatio(
          aspectRatio: 1.6,
          child: BarChart(
            BarChartData(
              barTouchData: BarTouchData(
                touchCallback: (touchEvent, touchResponse) {
                  if (touchResponse != null && touchResponse.spot != null) {
                    ref.read(currentMonthProvider.notifier).state =
                        touchResponse.spot!.touchedBarGroup.x;
                    return;
                  }

                  ref.read(currentMonthProvider.notifier).state =
                      DateTime.now().month;
                },
              ),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) => SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 14,
                      child: Text(
                        months[value.toInt() - 1].monthName.substring(0, 3),
                      ),
                    ),
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              barGroups: monthlyTransactions
                  .where((element) => element.year == currentYear)
                  .map(
                    (e) => BarChartGroupData(
                      x: e.month,
                      barRods: [
                        BarChartRodData(
                          width: 20,
                          borderRadius: BorderRadius.circular(5),
                          toY: e.totalAmount,
                          color:
                              e.year == currentYear && e.month == currentMonth
                                  ? Palette.primary
                                  : Palette.secondary,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
      error: (err, trace) => const Center(
        child: Text("Some error occured"),
      ),
      loading: () => const Skeleton(height: 100),
    );
  }
}
