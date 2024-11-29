import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/extension/spacing.dart';
import 'package:flutter_cart/modules/product_list/widget/product_item.dart';
import 'package:flutter_cart/utils/screen_utils.dart';
import 'package:flutter_cart/utils/text_utils.dart';
import 'package:flutter_cart/widget/app_bar.dart';
import 'package:flutter_cart/widget/custom_text.dart';
import 'package:flutter_cart/widget/custom_ui.dart';

import '../../../const/color_const.dart';
import '../../../extension/hex_color.dart';
import '../../../service/value_handler.dart';
import '../../../widget/custom_button.dart';
import '../../product_list/model/product.dart';
import '../bloc/local_cart_bloc.dart';

class LocalCartView extends StatefulWidget {
  const LocalCartView({super.key});

  @override
  State<LocalCartView> createState() => _LocalCartViewState();
}

class _LocalCartViewState extends State<LocalCartView> {
  LocalCartBloc _localCartBloc = LocalCartBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _localCartBloc..add(GetCartProductList()),
      child: BlocBuilder<LocalCartBloc, LocalCartState>(
        builder: (context, state) {
          return state is LocalCartLoading || state is LocalCartInitial
              ? const Center(child: CircularProgressIndicator())
              : state is LocalCartError
                  ? CustomContainer(
                      color: Colors.red,
                      child:
                          CustomTextEnum(state.message ?? "", color: Colors.red)
                              .textSM(),
                    )
                  : Scaffold(
                      appBar: CustomAppbar(
                        title: "Cart",
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 17),
                            child: CustomIconButton(
                                onPressed: () async {},
                                icon: Icon(
                                  Icons.remove_shopping_cart_outlined,
                                  color: HexColor.fromHex(ColorConst.error500),
                                )),
                          ),
                        ],
                      ),
                      bottomNavigationBar: CustomContainer(
                          color: HexColor.fromHex(ColorConst.gray25),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        HexColor.fromHex(ColorConst.success100),
                                    child: Icon(
                                      CupertinoIcons.cart_badge_plus,
                                      color: HexColor.fromHex(
                                          ColorConst.success600),
                                    ),
                                  ),
                                  10.pw,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      7.ph,
                                      CustomTextEnum(
                                              "${TextUtils.rupee}${(state as LocalCartLoaded).totalPayableAmount}")
                                          .textBoldMD(),
                                      CustomRichText(textSpanList: [
                                        CustomTextSpanEnum(
                                                text:
                                                    "${TextUtils.rupee}${(state).totalSavings} savings",
                                                color: HexColor.fromHex(
                                                    ColorConst.primaryDark))
                                            .textSM(),
                                        CustomTextSpanEnum(
                                                text: " | ",
                                                color: HexColor.fromHex(
                                                    ColorConst.gray400))
                                            .textSM(),
                                        CustomTextSpanEnum(
                                                text:
                                                    "${(state).totalItems} item(s)",
                                                color: HexColor.fromHex(
                                                    ColorConst.primaryDark))
                                            .textSM(),
                                      ]),
                                    ],
                                  ),
                                ],
                              ),
                              CustomGOEButton(
                                onPressed: (ValueHandler()
                                        .isNonZeroNumericValue(
                                            (state).totalPayableAmount))
                                    ? () {}
                                    : null,
                                backGroundColor: (ValueHandler()
                                        .isNonZeroNumericValue(
                                            (state).totalPayableAmount))
                                    ? HexColor.fromHex(ColorConst.success600)
                                    : HexColor.fromHex(ColorConst.success600),
                                size: Size(ScreenUtils.aw() * 0.35, 48),
                                child: CustomTextEnum("Proceed",
                                        color: (ValueHandler()
                                                .isNonZeroNumericValue(
                                                    (state).totalPayableAmount))
                                            ? HexColor.fromHex(ColorConst.white)
                                            : HexColor.fromHex(
                                                ColorConst.gray400))
                                    .textBoldMD(),
                              )
                            ],
                          )),
                      body: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomContainer(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: CustomTextEnum("Coupons (Coming Soon)",
                                        color: HexColor.fromHex(
                                            ColorConst.gray500))
                                    .textSM()),
                            10.ph,
                            (state).productList?.isEmpty == true
                                ? const Center(
                                    child: Icon(Icons.hourglass_empty))
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: (state).productList?.length ?? 0,
                                    itemBuilder: (_, int index) {
                                      Product? product =
                                          (state).productList?.elementAt(index);
                                      return ProductItem(
                                        product: product,
                                        isCartPage: true,
                                      );
                                    })
                          ],
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
