import 'package:flutter/material.dart';
import 'package:flutter_cart/extension/spacing.dart';
import 'package:flutter_cart/modules/product_list/widget/product_add_edit_button.dart';

import '../../../const/color_const.dart';
import '../../../extension/hex_color.dart';
import '../../../utils/text_utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/custom_ui.dart';
import '../model/product.dart';

class ProductItem extends StatelessWidget {
  final Product? product;
  final bool isCartPage;

  const ProductItem(
      {super.key, required this.product, this.isCartPage = false});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          4.ph,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomContainer(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                borderColor: HexColor.fromHex(ColorConst.gray400),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                child: CustomNetWorkImageView(
                  url: product?.productImage ?? "",
                  height: 48,
                  width: 48,
                ),
              ),
              10.pw,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextEnum(product?.displayName ?? "",
                          color: HexColor.fromHex(ColorConst.primaryDark))
                      .textXS(),
                  CustomTextEnum(product?.mfgGroup ?? "",
                          color: HexColor.fromHex(ColorConst.gray500))
                      .textXS(),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomTextEnum(
                          "${TextUtils.rupee}${product?.offerPrice.toString() ?? ""}",
                          color: HexColor.fromHex(ColorConst.primaryDark))
                      .textMediumSM(),
                  5.pw,
                  CustomTextEnum("${TextUtils.rupee}${product?.bBMRP ?? ""}",
                          decoration: TextDecoration.lineThrough,
                          color: HexColor.fromHex(ColorConst.gray400))
                      .textXS(),
                  5.pw,
                  CustomContainer(
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                    color: HexColor.fromHex(ColorConst.complimentary600),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: CustomTextEnum(
                            "${product?.bBDiscountPercent ?? ""}% Off",
                            color: Colors.white)
                        .textMediumXS(),
                  ),
                ],
              ),
              ProductCartAddEditToCartButton(product: product,isCart: isCartPage,),
            ],
          ),
          4.ph,
        ],
      ),
    );
  }
}
