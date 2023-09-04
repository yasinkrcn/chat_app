import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  //*Insets
  double get viewInsetsBottom => MediaQuery.of(this).viewInsets.bottom;
  double get viewInsetsTop => MediaQuery.of(this).viewInsets.top;

  //*Padding
  double get viewPaddingBottom => MediaQuery.of(this).viewPadding.bottom;
  double get viewPaddingTop => MediaQuery.of(this).viewPadding.top;
}
