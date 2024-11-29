import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/router/custom_router/custom_route.dart';
import 'package:flutter_cart/router/router_name.dart';
import 'package:flutter_cart/widget/custom_text.dart';
import 'package:flutter_cart/widget/custom_text_formfield.dart';
import 'package:go_router/go_router.dart';

import '../../../const/color_const.dart';
import '../../../extension/hex_color.dart';
import '../../../extension/logger_extension.dart';
import '../../../service/value_handler.dart';
import '../../../storage/product_sotrage/product_storage.dart';
import '../../../utils/screen_utils.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/custom_button.dart';
import '../../product_list/model/product.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String count = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCountUpdate();
    });
  }

  Future<void> getCountUpdate() async {
    List<Product> list = await ProductStorage.instance.getAllProducts();
    setState(() => count = list.length.toString());

    AppLog.d(list.map((product) => product.displayName).join(", "),
        tag: "Onion_prd--:");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Home",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 17),
            child: Badge(
                backgroundColor: HexColor.fromHex(ColorConst.error500),
                label: CustomText(count),
                isLabelVisible: ValueHandler().isTextNotEmptyOrNull(count),
                child: CustomIconButton(
                    onPressed: () async {
                      await getCountUpdate();
                    },
                    icon: Icon(Icons.shopping_cart_outlined))),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: CustomTextFormField(
              readOnly: true,
              label: "Search your desired!",
              onTap: () {
                // CustomRoute().goto(routeName: RouteName.products);
                String routeName = RouteName.products;
                if (kIsWeb) {
                  context.goNamed(routeName);
                } else {
                  context.pushNamed(routeName).then((_) async {
                    await getCountUpdate();
                  });
                }
              },
              suffix: Icon(
                Icons.search,
                size: 17,
                color: HexColor.fromHex(ColorConst.gray500),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomGOEButton(
                  backGroundColor: Colors.purpleAccent,
                  onPressed: () {
                    CustomRoute().goto(routeName: RouteName.products);
                  },
                  size: Size(ScreenUtils.aw() * 0.4, 48),
                  child: CustomTextEnum("Product List", color: Colors.white)
                      .textBoldSM()),
              CustomGOEButton(
                  backGroundColor: Colors.purpleAccent,
                  onPressed: () async {
                    await ProductStorage.instance.clearAllProducts();
                    setState(() => count = "");
                  },
                  size: Size(ScreenUtils.aw() * 0.4, 48),
                  child:
                      CustomTextEnum("Remove all Product", color: Colors.white)
                          .textBoldSM()),
            ],
          ),
        ],
      ),
    );
  }
}
