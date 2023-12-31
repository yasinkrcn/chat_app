import 'package:chat_app/core/_core_exports.dart';

extension NumExtension on num {
  double get h => ScreenSize().getHeight(this);

  double get w => ScreenSize().getWidth(this);

  double get sp => ScreenSize().getSp(this);

  double get r => ScreenSize().radius(this);
}

extension NumNullableExtension on num? {
  bool get isNotNull => this != null;
  num get getValueOrDefault => this ?? 0;
  bool get isZero => getValueOrDefault == 0;
}
