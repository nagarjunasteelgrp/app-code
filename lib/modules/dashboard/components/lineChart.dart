import 'package:digital_lync/modules/dashboard/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatefulWidget {
  DashboardProvider provider;
  LineChartWidget({super.key, required this.provider});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(
          labelRotation: - 30,
          labelStyle: TextStyle(fontSize: 10),
          plotOffset: 0,
        ),
        legend: const Legend(isVisible: false),
        tooltipBehavior: TooltipBehavior(enable: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          shouldAlwaysShow: false,
        ),
        series: <CartesianSeries<dynamic, dynamic>>[
          LineSeries<SalesData, String>(
            dataSource: widget.provider.fabricatorsChartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            enableTooltip: true,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          LineSeries<SalesData, String>(
            dataSource: widget.provider.dealerChartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            enableTooltip: true,
            color: Theme.of(context).colorScheme.outline,
          ),
          LineSeries<SalesData, String>(
            dataSource: widget.provider.customerChartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            enableTooltip: true,
            color: Theme.of(context).colorScheme.onInverseSurface,
          )
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
