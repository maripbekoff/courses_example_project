import 'package:flutter/cupertino.dart';

class AppTheme {
  static const String kFontFamily = 'Manrope';

  static const CupertinoTextThemeData theme = CupertinoTextThemeData(
    primaryColor: CupertinoColors.black,
    textStyle: TextStyle(
      color: CupertinoColors.black,
      fontSize: 16,
      fontFamily: kFontFamily,
    ),
    navTitleTextStyle: TextStyle(
      color: CupertinoColors.black,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontFamily: kFontFamily,
    ),
  );
}
