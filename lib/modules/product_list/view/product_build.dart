import 'package:flutter/material.dart';
import 'package:flutter_cart/extension/logger_extension.dart';
import 'package:flutter_cart/extension/spacing.dart';
import 'package:flutter_cart/utils/screen_utils.dart';
import 'package:flutter_cart/utils/text_utils.dart';
import 'package:flutter_cart/widget/custom_button.dart';
import 'package:flutter_cart/widget/custom_image.dart';
import 'package:flutter_cart/widget/custom_text.dart';

import '../model/product.dart';

class ProductBuild extends StatelessWidget {
  final List<Product>? prdList;

  const ProductBuild({super.key, required this.prdList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: prdList?.length ?? 0,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          itemBuilder: (_, int index) {
            Product? product = prdList?.elementAt(index);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomNetWorkImageView(
                      url:
                          "https://res.retailershakti.com/incom/images/product/thumb/${product?.productImage ?? " "}",
                      height: 48,
                      width: 48,
                    ),
                    15.pw,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: ScreenUtils.aw() * 0.4,
                            child: CustomTextEnum(product?.displayName ?? "")
                                .textSM()),
                        5.ph,
                        CustomTextEnum(
                                "${TextUtils.rupee}${product?.offerPrice.toString() ?? " "}")
                            .textSemiboldSM(),
                      ],
                    ),
                  ],
                ),
                CustomGOEButton(
                    backGroundColor: Colors.green,
                    radius: 8,
                    child: CustomText("Add", color: Colors.white),
                    onPressed: () {
                      AppLog.v(
                          "Onion--->${product?.productId.toString() ?? " "}");
                    }),
              ],
            );
          }),
    );
  }
}
