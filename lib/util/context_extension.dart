import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;
  double dynamicShortest(double val) =>
      MediaQuery.of(this).size.shortestSide * val;
  ThemeData get theme => Theme.of(this);
}

extension NumberExtension on BuildContext {
  double get lowValue => dynamicHeight(0.01);
  double get mediumValue => dynamicHeight(0.03);
  double get highValue => dynamicHeight(0.05);
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingAllowLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingAllowMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingAllowHigh => EdgeInsets.all(highValue);
}

extension EmptyWidget on BuildContext {
  Widget get emptyWidgetHeightLow => SizedBox(height: lowValue);
  Widget get emptyWidgetHeightMedium => SizedBox(height: mediumValue);
  Widget get emptyWidgetHeightHigh => SizedBox(height: highValue);
  Widget get emptyWidgetWidthLow => SizedBox(width: lowValue);
  Widget get emptyWidgetWidthMedium => SizedBox(width: mediumValue);
  Widget get emptyWidgetWidthHigh => SizedBox(width: highValue);
}
