import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/router/custom_router/custom_route.dart';
import 'package:flutter_cart/router/router_name.dart';
import 'package:flutter_cart/storage/local_product_bloc/local_products_bloc.dart';
import 'package:flutter_cart/widget/custom_text.dart';
import 'package:flutter_cart/widget/custom_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../const/color_const.dart';
import '../../../extension/hex_color.dart';
import '../../../service/value_handler.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/custom_button.dart';
import '../bloc/dashboard_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardBloc _dashboardBloc = DashboardBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _dashboardBloc..add(GetProductListCount()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return BlocListener<LocalProductsBloc, LocalProductsState>(
            listener: (context, state) {
              if (state is LocalProductListLoaded) {
                _dashboardBloc.add(GetProductListCount());
              }
            },
            child: Scaffold(
              appBar: CustomAppbar(
                title: "Home",
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 17),
                    child: Badge(
                        backgroundColor: HexColor.fromHex(ColorConst.error500),
                        label: CustomText(
                            "${state is DashboardLoaded ? state.productCount : "0"}"),
                        isLabelVisible: ValueHandler().isTextNotEmptyOrNull(
                            state is DashboardLoaded
                                ? state.productCount
                                : "0"),
                        child: CustomIconButton(
                            onPressed: () async {
                              CustomRoute().goto(routeName: RouteName.cart);
                            },
                            icon: Icon(Icons.shopping_cart_outlined))),
                  ),
                ],
              ),
              body: Column(
                children: [
                  /*Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                            // await getCountUpdate();
                          });
                        }
                      },
                      suffix: Icon(
                        Icons.search,
                        size: 17,
                        color: HexColor.fromHex(ColorConst.gray500),
                      ),
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: InkWell(
                      onTap: () {
                        String routeName = RouteName.products;
                        if (kIsWeb) {
                          context.goNamed(routeName);
                        } else {
                          context.pushNamed(routeName).then((_) async {
                            // await getCountUpdate();
                          });
                        }
                      },
                      child: CustomContainer(
                          padding: const EdgeInsets.all(10),
                          borderColor: HexColor.fromHex(ColorConst.gray400),
                          borderRadius: BorderRadius.circular(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextEnum("Search your desired!",
                                      color: HexColor.fromHex(
                                          ColorConst.primaryDark))
                                  .textSM(),
                              Icon(Icons.search,
                                  color:
                                      HexColor.fromHex(ColorConst.primaryDark)),
                            ],
                          )),
                    ),
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomGOEButton(
                          backGroundColor: Colors.purpleAccent,
                          onPressed: () {
                            CustomRoute().goto(routeName: RouteName.products);
                          },
                          size: Size(ScreenUtils.aw() * 0.4, 48),
                          child: CustomTextEnum("Product List",
                                  color: Colors.white)
                              .textBoldSM()),
                      CustomGOEButton(
                          backGroundColor: Colors.purpleAccent,
                          onPressed: () async {
                            await ProductStorage.instance.clearAllProducts();

                            var count = state is DashboardLoaded
                                ? state.productCount
                                : "0";
                            count = 0;

                            PopUpItems().toastfy("Cart cleared successfully!",
                                HexColor.fromHex(ColorConst.error500),
                                type: ToastificationType.error);
                          },
                          size: Size(ScreenUtils.aw() * 0.4, 48),
                          child: CustomTextEnum("Remove all Product",
                                  color: Colors.white)
                              .textBoldSM()),
                    ],
                  ),*/
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
