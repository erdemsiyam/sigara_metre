import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigara_metre/pages/chart/widget/smoke_chart_widget.dart';
import 'package:sigara_metre/pages/chart/widget/stress_chart_widget.dart';
import 'package:sigara_metre/provider/chart_provider.dart';
import 'package:sigara_metre/util/context_extension.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class ChartPage extends StatelessWidget {
  ChartProvider _chartProvider;
  @override
  Widget build(BuildContext context) {
    _chartProvider = Provider.of<ChartProvider>(context, listen: false);

    initData();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: topButtons(context),
            ),
            Expanded(
              flex: 1,
              child: selectDateWidget(context),
            ),
            Expanded(
              flex: 6,
              child: SmokeChartWidget(),
            ),
            Expanded(
              flex: 6,
              child: StressChartWidget(),
            ),
          ],
        ),
      ),
    );
  }

  void initData() {
    // ilk veri çekilir
    if (_chartProvider.chartData == ChartData.INIT) {
      _chartProvider.getChartsData(DateTime.now(), DateTime.now());
    }
  }

  Widget topButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: context.dynamicShortest(0.09),
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.delete_outline,
            size: context.dynamicShortest(0.07),
            color: Colors.blue,
          ),
          onPressed: () {
            customShowDialog(context);
          },
        ),
      ],
    );
  }

  void customShowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Delete All Data'),
          content: Text('Dou you want to delete all data?'),
          actions: [
            TextButton(
              onPressed: () {
                _chartProvider.deleteAllData();
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: context.theme.textTheme.bodyText1.copyWith(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: context.theme.textTheme.bodyText1,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget selectDateWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.dynamicShortest(0.02),
        horizontal: context.dynamicShortest(0.06),
      ),
      child: ElevatedButton(
        onPressed: () => onSelectDate(context),
        child: Text(
          'Select Date Range',
          style: TextStyle(
            color: Colors.white,
            fontSize: context.dynamicShortest(0.04),
          ),
        ),
      ),
    );
  }

  void onSelectDate(BuildContext context) async {
    List<DateTime> picked = await DateRangePicker.showDatePicker(
      context: context,
      initialFirstDate: (DateTime.now()).add(Duration(days: -7)),
      initialLastDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
    );
    if (picked != null && picked.length == 2) {
      _chartProvider.getChartsData(picked[0], picked[1]);
    }
  }
}
