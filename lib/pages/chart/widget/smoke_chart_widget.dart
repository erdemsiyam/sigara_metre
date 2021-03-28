import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigara_metre/provider/chart_provider.dart';
import 'package:sigara_metre/util/context_extension.dart';

class SmokeChartWidget extends StatelessWidget {
  ChartProvider _chartProvider;
  @override
  Widget build(BuildContext context) {
    // flSpots.add(FlSpot(1, 1));
    // flSpots.add(FlSpot(2, 0));
    // flSpots.add(FlSpot(3, 2));
    // flSpots.add(FlSpot(4, 0));
    // flSpots.add(FlSpot(5, 3));
    // flSpots.add(FlSpot(6, 0));
    // flSpots.add(FlSpot(23, 4));
    _chartProvider = Provider.of<ChartProvider>(context);
    switch (_chartProvider.chartData) {
      case ChartData.INIT:
      case ChartData.LOADING:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        );
      case ChartData.DONE:
        return chart(context);
    }
  }

  Widget chart(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(
            context.dynamicShortest(0.05),
          )),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            context.emptyWidgetHeightLow,
            Row(
              children: [
                context.emptyWidgetWidthHigh,
                Text(
                  'Smoke Count',
                  style: TextStyle(
                      fontSize: context.dynamicShortest(0.05),
                      color: Colors.blue),
                ),
              ],
            ),
            context.emptyWidgetHeightMedium,
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.dynamicShortest(0.03),
                ),
                child: LineChart(
                  sampleData(context),
                  swapAnimationDuration: Duration(milliseconds: 250),
                ),
              ),
            ),
            context.emptyWidgetHeightMedium,
          ],
        ),
      ),
    );
  }

  LineChartData sampleData(BuildContext context) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          getTitles: (value) {
            return value.toInt().toString();
          },
          getTextStyles: (_) => context.theme.textTheme.bodyText1.copyWith(
            fontSize: context.dynamicShortest(0.03),
            color: Colors.black87,
          ),
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTitles: (value) {
            return value.toString();
          },
          margin: context.dynamicShortest(0.02),
          getTextStyles: (_) => context.theme.textTheme.bodyText1.copyWith(
            fontSize: context.dynamicShortest(0.03),
            color: Colors.black87,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 2,
          ),
          left: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
      minX: 1,
      maxX: 24,
      maxY: 10,
      minY: 0,
      lineBarsData: [linesBarData(context)],
    );
  }

  LineChartBarData linesBarData(BuildContext context) {
    return LineChartBarData(
      spots: _chartProvider.spotSmokes,
      isCurved: false,
      colors: [
        Colors.blue,
      ],
      barWidth: context.dynamicShortest(0.005),
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
  }
}
