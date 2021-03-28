import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigara_metre/provider/chart_provider.dart';
import 'package:sigara_metre/util/context_extension.dart';

class StressChartWidget extends StatelessWidget {
  ChartProvider _chartProvider;
  @override
  Widget build(BuildContext context) {
    // flSpotsFine.add(FlSpot(1, 0));
    // flSpotsFine.add(FlSpot(2, 1));
    // flSpotsFine.add(FlSpot(3, 0));
    // // flSpotsFine.add(FlSpot(4, 0));
    // // flSpotsFine.add(FlSpot(5, 0));
    // // flSpotsFine.add(FlSpot(6, 0));
    // // flSpotsFine.add(FlSpot(7, 0));

    // // flSpotsNormal.add(FlSpot(1, 0));
    // flSpotsNormal.add(FlSpot(2, 0));
    // flSpotsNormal.add(FlSpot(3, 3));
    // flSpotsNormal.add(FlSpot(4, 2));
    // flSpotsNormal.add(FlSpot(5, 0));
    // flSpotsNormal.add(FlSpot(6, 2));
    // flSpotsNormal.add(FlSpot(7, 1));
    // flSpotsNormal.add(FlSpot(8, 0));
    // // flSpotsNormal.add(FlSpot(6, 0));
    // // flSpotsNormal.add(FlSpot(7, 0));

    // // flSpotsStress.add(FlSpot(1, 0));
    // // flSpotsStress.add(FlSpot(2, 0));
    // // flSpotsStress.add(FlSpot(3, 0));
    // // flSpotsStress.add(FlSpot(4, 0));
    // flSpotsStress.add(FlSpot(5, 0));
    // flSpotsStress.add(FlSpot(6, 5));
    // flSpotsStress.add(FlSpot(7, 2));
    // flSpotsStress.add(FlSpot(8, 0));

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
                  'Stress Frequency',
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
      lineBarsData: [
        linesBarDataFine(context),
        linesBarDataNormal(context),
        linesBarDataStress(context),
      ],
    );
  }

  LineChartBarData linesBarDataFine(BuildContext context) {
    return LineChartBarData(
      spots: _chartProvider.spotStressLow,
      isCurved: false,
      colors: [
        Colors.green,
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

  LineChartBarData linesBarDataNormal(BuildContext context) {
    return LineChartBarData(
      spots: _chartProvider.spotStressMedium,
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

  LineChartBarData linesBarDataStress(BuildContext context) {
    return LineChartBarData(
      spots: _chartProvider.spotStressHigh,
      isCurved: false,
      colors: [
        Colors.red,
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
