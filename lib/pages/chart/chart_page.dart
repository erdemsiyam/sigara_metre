import 'package:flutter/material.dart';
import 'package:sigara_metre/pages/chart/widget/smoke_chart_widget.dart';
import 'package:sigara_metre/pages/chart/widget/stress_chart_widget.dart';
import 'package:sigara_metre/util/context_extension.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            // TODO  delete
          },
        ),
      ],
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
      // TODO alttakini aç
      // _smokeProvider.getChartsData(picked[0], picked[1]);
    }
  }
}
