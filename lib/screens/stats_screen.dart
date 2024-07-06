import 'package:cash_wise2/widgets/charts/bar_charts/bar_chart_daily.dart';
import 'package:cash_wise2/widgets/charts/bar_charts/bar_chart_monthly.dart';
import 'package:cash_wise2/widgets/charts/bar_charts/bar_chart_weekly.dart';
import 'package:flutter/material.dart';


class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 3, // The number of tabs
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          title:  Text('Statistics',
            style: theme.textTheme.bodyLarge,),
          bottom:  TabBar(
            tabs: [
              Tab(child: Text('Daily', style: theme.textTheme.bodySmall)),
              Tab(child: Text('Weekly', style: theme.textTheme.bodySmall)),
              Tab(child: Text('Monthly', style: theme.textTheme.bodySmall)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BarChartDaily(),
            BarChartWeekly(),
            BarChartMonthly()
          ],
        ),
      ),
    );
  }
}