import 'dart:math';

import 'package:chat_app/core/constants/app_constants.dart';

import '../_core_exports.dart';

class ScreenSize {
  static final ScreenSize _instance = ScreenSize._init();
  ScreenSize._init();

  factory ScreenSize() {
    return _instance;
  }

  factory ScreenSize.init(BuildContext context) {
    _instance.screenSize = MediaQuery.of(context).size;
    _instance.bottomMargin = MediaQuery.of(context).padding.bottom;
    _instance.topMargin = MediaQuery.of(context).padding.top;
    _instance.centerOfHeight = _instance.screenSize.height / 2;
    _instance.centerOfWidht = _instance.screenSize.width / 2;

    return _instance;
  }

  late Size screenSize;
  late double topMargin;
  late double bottomMargin;
  late double centerOfHeight;
  late double centerOfWidht;

  double getHeightPercent(double percent) {
    return screenSize.height * percent;
  }

  double getWidthPercent(double percent) {
    return screenSize.width * percent;
  }

  double getHeight(num heightNum) {
    double height = (screenSize.height * heightNum) / AppConstants().designDeviceSize.height;
    return height;
  }

  double getWidth(num widthNum) {
    double width = (screenSize.width * widthNum) / AppConstants().designDeviceSize.width;
    return width;
  }

  double getBodyHeightWithAppBar() {
    return screenSize.height - (topMargin + bottomMargin + 56);
  }

  double getBodyHeightNotAppBar() {
    return screenSize.height - (topMargin + bottomMargin);
  }

  double getSp(num fontSize) => fontSize * _scaleText;

  double radius(num r) {
    return r *
        min((screenSize.width / AppConstants().designDeviceSize.width),
            (screenSize.height / AppConstants().designDeviceSize.height));
  }

  double get sizeRatio => screenSize.aspectRatio / AppConstants().designDeviceSize.aspectRatio;

  double get _scaleText => min(_scaleWidth, _scaleHeight);

  double get _scaleWidth => screenSize.width / AppConstants().designDeviceSize.width;

  double get _scaleHeight => screenSize.height / AppConstants().designDeviceSize.height;

  set setScreenSize(Size size) => screenSize = size;
}
