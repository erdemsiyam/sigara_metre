import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigara_metre/pages/home/enum/stress_enum.dart';
import 'package:sigara_metre/pages/home/widget/last_texts_widget.dart';
import 'package:sigara_metre/provider/home_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:sigara_metre/util/context_extension.dart';

class HomePage extends StatelessWidget {
  HomeProvider _homeProvider;
  Stress _stress;
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(flex: 1, child: rightButton(context)),
            Expanded(flex: 1, child: SizedBox()),
            Expanded(flex: 4, child: LastTextsWidget()),
            Expanded(flex: 1, child: SizedBox()),
            Expanded(flex: 4, child: addSmokeWidget(context)),
          ],
        ),
      ),
    );
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
          onPressed: () {},
        ),
        context.emptyWidgetWidthMedium,
      ],
    );
  }

  Widget addSmokeWidget(BuildContext context) {
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return Column(
      children: [
        SizedBox(
          width: context.dynamicWidth(0.6),
          height: context.dynamicHeight(0.1),
          child: FittedBox(
            child: toggleButton(context),
          ),
        ),
        context.emptyWidgetHeightMedium,
        SizedBox(
          width: context.dynamicShortest(0.1),
          height: context.dynamicShortest(0.1),
          child: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: context.dynamicShortest(0.07),
            ),
            onPressed: () {
              _homeProvider.addSmoke(_stress);
            },
          ),
        ),
      ],
    );
  }

  Widget toggleButton(BuildContext context) {
    return ToggleSwitch(
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
    );
  }
}
