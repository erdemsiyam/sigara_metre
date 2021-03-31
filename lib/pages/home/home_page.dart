import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigara_metre/pages/chart/chart_page.dart';
import 'package:sigara_metre/pages/home/enum/stress_enum.dart';
import 'package:sigara_metre/pages/home/widget/ad_widget.dart';
import 'package:sigara_metre/pages/home/widget/last_texts_widget.dart';
import 'package:sigara_metre/provider/chart_provider.dart';
import 'package:sigara_metre/provider/home_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:sigara_metre/util/context_extension.dart';

class HomePage extends StatelessWidget {
  HomeProvider _homeProvider;
  Stress _stress = Stress.MEDIUM;
  @override
  Widget build(BuildContext context) {
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    initData();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(flex: 1, child: rightButton(context)),
            Expanded(flex: 1, child: SizedBox()),
            Expanded(flex: 6, child: LastTextsWidget()),
            Expanded(flex: 1, child: SizedBox()),
            Expanded(flex: 6, child: addSmokeWidget(context)),
            Expanded(flex: 2, child: MyAdWidget()),
          ],
        ),
      ),
    );
  }

  void initData() {
    if (_homeProvider.textState == TextState.INIT) {
      _homeProvider.getCounts();
    }
  }

  Widget rightButton(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(
            Icons.chevron_right,
            size: context.dynamicShortest(0.09),
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<ChartProvider>(
                  create: (_) => ChartProvider(),
                  child: ChartPage(),
                ),
              ),
            );
          },
        ),
        context.emptyWidgetWidthMedium,
      ],
    );
  }

  Widget addSmokeWidget(BuildContext context) {
    return Column(
      children: [
        toggleButton(context),
        context.emptyWidgetHeightMedium,
        addButton(context),
      ],
    );
  }

  Widget toggleButton(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(0.6),
      height: context.dynamicHeight(0.1),
      child: FittedBox(
        child: ToggleSwitch(
          minWidth: context.dynamicWidth(0.2),
          minHeight: context.dynamicHeight(0.1),
          fontSize: context.dynamicShortest(0.04),
          cornerRadius: context.dynamicShortest(0.05),
          initialLabelIndex: 1,
          activeBgColor: Colors.blue,
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.white,
          inactiveFgColor: Colors.blue,
          labels: ['Stress', 'Normal', 'Fine'],
          activeBgColors: [Colors.red, Colors.blue, Colors.green],
          onToggle: (index) {
            switch (index) {
              case 0:
                _stress = Stress.HIGH;
                break;
              case 1:
                _stress = Stress.MEDIUM;
                break;
              case 2:
                _stress = Stress.LOW;
                break;
            }
          },
        ),
      ),
    );
  }

  Widget addButton(BuildContext context) {
    return SizedBox(
      width: context.dynamicShortest(0.13),
      height: context.dynamicShortest(0.13),
      child: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: context.dynamicShortest(0.09),
        ),
        onPressed: () {
          _homeProvider.addSmoke(_stress);
        },
      ),
    );
  }
}
