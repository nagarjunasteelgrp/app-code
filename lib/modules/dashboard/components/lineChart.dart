import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 350,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(
            show: true,
            drawVerticalLine: false, // Disable vertical grid lines
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return Text(value.toInt().toString());
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Jan');
                    case 1:
                      return const Text('Feb');
                    case 2:
                      return const Text('Mar');
                    case 3:
                      return const Text('Apr');
                    case 4:
                      return const Text('May');
                    case 5:
                      return const Text('Jun');
                    case 6:
                      return const Text('Jul');
                    case 7:
                      return const Text('Aug');
                    case 8:
                      return const Text('Sep');
                    case 9:
                      return const Text('Oct');
                    case 10:
                      return const Text('Nov');
                    case 11:
                      return const Text('Dec');
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.black, width: 1),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 0),
                const FlSpot(1, 3),
                const FlSpot(2, 2),
                const FlSpot(3, 5),
                const FlSpot(4, 5),
                const FlSpot(5, 2),
                const FlSpot(6, 1),
                const FlSpot(7, 3),
                const FlSpot(8, 2),
                const FlSpot(9, 5),
                const FlSpot(10, 5),
                const FlSpot(11, 6),
              ],
              isCurved: true,
              color: Theme.of(context).colorScheme.outline,
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: [
                const FlSpot(0, 0),
                const FlSpot(1, 2.5),
                const FlSpot(2, 3),
                const FlSpot(3, 4),
                const FlSpot(4, 3),
                const FlSpot(5, 4.5),
                const FlSpot(6, 3.5),
                const FlSpot(7, 4),
                const FlSpot(8, 3),
                const FlSpot(9, 4.5),
                const FlSpot(10, 4),
                const FlSpot(11, 5),
              ],
              isCurved: true,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: [
                const FlSpot(0, 0),
                const FlSpot(1, 1.5),
                const FlSpot(2, 4),
                const FlSpot(3, 2.5),
                const FlSpot(4, 4.5),
                const FlSpot(5, 3),
                const FlSpot(6, 4.5),
                const FlSpot(7, 2),
                const FlSpot(8, 4),
                const FlSpot(9, 3),
                const FlSpot(10, 4.5),
                const FlSpot(11, 2.5),
              ],
              isCurved: true,
              color: Theme.of(context).colorScheme.onInverseSurface,
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
