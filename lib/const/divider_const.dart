import 'package:flutter/material.dart';

import '../extension/hex_color.dart';
import 'color_const.dart';

class CustomDivider {
  Widget thinDivider() {
    return SizedBox(
      height: 8.0,
      child: Center(
        child: Container(
          margin: const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
          height: 1.0,
          color: HexColor.fromHex(ColorConst.gray100),
        ),
      ),
    );
  }

  Widget thickDivider() {
    return SizedBox(
      height: 8.0,
      child: Center(
        child: Container(
          margin: const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
          height: 7.0,
          color: HexColor.fromHex(ColorConst.gray100),
        ),
      ),
    );
  }

  Widget normalDivider({double? height}) {
    return Divider(
        color: HexColor.fromHex(ColorConst.lineGrey),
        height: height ?? 1,
        endIndent: 0,
        indent: 0);
  }
}
