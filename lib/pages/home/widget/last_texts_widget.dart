import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigara_metre/provider/home_provider.dart';
import 'package:sigara_metre/util/context_extension.dart';

class LastTextsWidget extends StatelessWidget {
  HomeProvider _homeProvider;
  @override
  Widget build(BuildContext context) {
    _homeProvider = Provider.of<HomeProvider>(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 10,
          child: Align(
            alignment: Alignment.centerRight,
            child: leftPart(context),
          ),
        ),
        Expanded(flex: 1, child: SizedBox()),
        VerticalDivider(
          color: Colors.blue,
          thickness: context.dynamicShortest(0.005),
        ),
        Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 10,
          child: Align(
            alignment: Alignment.centerLeft,
            child: rightPart(context),
          ),
        ),
      ],
    );
  }

  Widget leftPart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        animationText(context, 'Last', 1),
        context.emptyWidgetHeightMedium,
        animationText(context, 'Today', 2),
        context.emptyWidgetHeightMedium,
        animationText(context, 'Total', 3),
      ],
    );
  }

  Widget rightPart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        animationText(
          context,
          (_homeProvider.areCountsVisible)
              ? _homeProvider.strLastSmokeTime
              : '',
          1,
        ),
        context.emptyWidgetHeightMedium,
        animationText(
          context,
          (_homeProvider.areCountsVisible)
              ? _homeProvider.intTodaySmoke.toString()
              : '',
          2,
        ),
        context.emptyWidgetHeightMedium,
        animationText(
          context,
          (_homeProvider.areCountsVisible)
              ? _homeProvider.intTotalSmoke.toString()
              : '',
          3,
        ),
      ],
    );
  }

  Widget animationText(BuildContext context, String text, int duration) {
    return AnimatedOpacity(
      opacity: (_homeProvider.areCountsVisible) ? 1 : 0,
      duration: Duration(seconds: duration),
      child: Text(
        text,
        style: context.theme.textTheme.headline5.copyWith(
          fontSize: context.dynamicShortest(0.08),
          color: Colors.blue,
        ),
      ),
    );
  }
}
