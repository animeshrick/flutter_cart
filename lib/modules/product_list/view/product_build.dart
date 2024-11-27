import 'package:flutter/material.dart';
import 'package:flutter_cart/extension/spacing.dart';
import 'package:flutter_cart/storage/product_sotrage/product_hive.dart';
import 'package:flutter_cart/utils/pop_up_items.dart';
import 'package:flutter_cart/utils/screen_utils.dart';
import 'package:flutter_cart/utils/text_utils.dart';
import 'package:flutter_cart/widget/custom_button.dart';
import 'package:flutter_cart/widget/custom_image.dart';
import 'package:flutter_cart/widget/custom_text.dart';
import 'package:toastification/toastification.dart';

import '../../../const/color_const.dart';
import '../../../extension/hex_color.dart';
import '../model/product.dart';

class ProductBuild extends StatefulWidget {
  final List<Product>? prdList;

  const ProductBuild({super.key, required this.prdList});

  @override
  State<ProductBuild> createState() => _ProductBuildState();
}

class _ProductBuildState extends State<ProductBuild> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.prdList?.length ?? 0,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        itemBuilder: (_, int index) {
          Product? product = widget.prdList?.elementAt(index);
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
                  child: const CustomText("Add", color: Colors.white),
                  onPressed: () async {
                    PopUpItems().toastfy(
                        "${product?.displayName ?? ""} added successfully!",
                        HexColor.fromHex(ColorConst.success200),
                        type: ToastificationType.success);
                    await ProductStorageHive()
                        .saveProduct(product ?? Product());
                    setState(() {

                    });
                  }),
            ],
          );
        });
  }
}
