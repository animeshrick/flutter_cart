import 'package:flutter/material.dart';
import 'package:flutter_cart/router/custom_router/custom_route.dart';
import 'package:flutter_cart/router/router_name.dart';
import 'package:flutter_cart/widget/custom_text.dart';
import 'package:flutter_cart/widget/custom_text_formfield.dart';

import '../../../const/color_const.dart';
import '../../../extension/hex_color.dart';
import '../../../widget/app_bar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Home",
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 17),
            child: Badge(
                label: CustomText("100"),
                child: Icon(Icons.shopping_cart_outlined)),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: CustomTextFormField(
              enabled: false,
              label: "Search your desired!",
              onTap: () {
                CustomRoute().goto(routeName: RouteName.products);
              },
              suffix: Icon(
                Icons.search,
                size: 17,
                color: HexColor.fromHex(ColorConst.gray500),
              ),
            ),
          ),
          /*Center(
            child: CustomGOEButton(
                backGroundColor: Colors.purpleAccent,
                onPressed: () {
                  CustomRoute().goto(routeName: RouteName.products);
                },
                size: Size(ScreenUtils.aw() * 0.5, 48),
                child: CustomTextEnum("Product List", color: Colors.white)
                    .textBoldSM()),
          ),*/
        ],
      ),
    );
  }
}
