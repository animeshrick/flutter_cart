import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extension/hex_color.dart';
import '../widget/custom_text.dart';
import 'color_const.dart';

class ThemeConst {
  static SystemUiOverlayStyle systemOverlayStyle = const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemStatusBarContrastEnforced: true,
    statusBarColor: Colors.white,
  );
  static AppBarTheme appBarTheme = AppBarTheme(
    systemOverlayStyle: systemOverlayStyle,
    elevation: 0.5,
    titleSpacing: 0,
    color: Colors.white,
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor:
        HexColor.fromHex(kIsWeb ? ColorConst.secondaryDark : ColorConst.gray25),
    centerTitle: false,
  );
  static TextTheme textTheme = TextTheme(
    bodyLarge: customizeTextStyle(
        fontColor: HexColor.fromHex(ColorConst.primaryDark),
        decorationColor: HexColor.fromHex(ColorConst.secondaryDark)),
    // Replaces bodyText1
    bodyMedium: customizeTextStyle(
        fontColor: HexColor.fromHex(ColorConst.primaryDark),
        decorationColor: HexColor.fromHex(ColorConst.secondaryDark)),
    // Replaces bodyText2
    bodySmall: customizeTextStyle(
        fontColor: HexColor.fromHex(ColorConst.primaryDark),
        decorationColor: HexColor.fromHex(ColorConst
            .secondaryDark)), // For smaller body text You can customize more text styles if needed
  );
  static ThemeData theme = ThemeData(
    pageTransitionsTheme: kIsWeb ? NoTransitionsOnWeb() : null,
    colorSchemeSeed: HexColor.fromHex(ColorConst.baseHexColor),
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: appBarTheme,
    textTheme: textTheme,
  );

  static ThemeData darkTheme = ThemeData(
    pageTransitionsTheme: kIsWeb ? NoTransitionsOnWeb() : null,
    colorSchemeSeed: HexColor.fromHex(ColorConst.baseHexColor),
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.dark,
    appBarTheme: appBarTheme,
    textTheme: textTheme,
  );
}

class NoTransitionsOnWeb extends PageTransitionsTheme {
  @override
  Widget buildTransitions<T>(
    route,
    context,
    animation,
    secondaryAnimation,
    child,
  ) {
    if (kIsWeb) {
      return child;
    }
    return super.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
