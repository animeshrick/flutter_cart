import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/modules/product_list/local_product_bloc/local_products_bloc.dart';

import '../../../const/color_const.dart';
import '../../../const/shadow_const.dart';
import '../../../extension/hex_color.dart';
import '../../../service/value_handler.dart';
import '../../../utils/text_utils.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/custom_ui.dart';
import '../model/product.dart';

class ProductCartAddEditToCartButton extends StatelessWidget {
  const ProductCartAddEditToCartButton({super.key, required this.product});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalProductsBloc, LocalProductsState>(
      builder: (context, state) {
        /// product filtered from product list
        final productList = state.productModel.items?.products?.notc ?? [];

        Product? cartProduct = Product();
        /*ProductCartUtils().filterCartProduct(
            allProductList: state.productList.value ?? [],
            productId: product?.productId ?? "")*/

        // AppLog.d(state.props, tag: "BLOC_State value");

        return product?.bBIsOutOfStock == "Y" ||
                !ValueHandler().isNonZeroNumericValue(product?.bBMRP)
            ? CustomGOEButton(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                size: const Size(81, 36),
                radius: 6,
                borderColor: HexColor.fromHex(ColorConst.secondaryDark),
                onPressed: () async {
                  /*CommonResponse? commonResponse = await ProductRequestRepo()
                      .submitServiceRequest(product: product);
                  PopUpItems().toastMessage(
                      commonResponse?.message ?? "Product Requested.",
                      HexColor.fromHex(ColorConst.success600),
                      durationSeconds: 3);*/
                },
                child: Center(
                  child: CustomTextEnum(
                    TextUtils.request,
                    color: HexColor.fromHex(ColorConst.secondaryDark),
                  ).textXS(),
                ))
            : (cartProduct.bBMinQty ?? 0) >= 1
                ? InkWell(
                    onTap: () {},
                    child: CustomContainer(
                      height: 38,
                      width: 81,
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: HexColor.fromHex(ColorConst.success200),
                        style: BorderStyle.solid,
                      ),
                      boxShadow: ShadowConst.shadowSB,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconButton(
                              iconSize: 14,
                              // color: HexColor.fromHex(ColorConst.brand600),
                              padding: const EdgeInsets.all(8),
                              icon: Icon(
                                cartProduct.bBMinQty == 1
                                    ? Icons.delete_outline
                                    : Icons.minimize,
                                color: HexColor.fromHex(ColorConst.success600),
                              ),
                              onPressed: () {
                                context.read<LocalProductsBloc>().add(
                                    RemoveSingleLocalProduct(
                                        product: product ?? Product()));
                              }),
                          CustomTextEnum(
                            "${cartProduct.bBMinQty}",
                            color: HexColor.fromHex(ColorConst.success600),
                          ).textSemiboldSM(),
                          CustomIconButton(
                              iconSize: 14,
                              // color: HexColor.fromHex(ColorConst.brand600),
                              padding: const EdgeInsets.all(8),
                              icon: Icon(
                                Icons.add,
                                color: HexColor.fromHex(ColorConst.success600),
                              ),
                              onPressed: () {}),
                        ],
                      ),
                    ),
                  )
                : CustomContainer(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: ShadowConst.shadowSB,
                    child: CustomGOEButton(
                        size: const Size(80, 36),
                        radius: 6,
                        borderColor: HexColor.fromHex(ColorConst.success200),
                        backGroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        onPressed: () {
                          context.read<LocalProductsBloc>().add(
                              AddSingleLocalProduct(
                                  product: product ?? Product()));
                        },
                        child: Center(
                          child: CustomTextEnum(
                            TextUtils.add.toUpperCase(),
                            color: HexColor.fromHex(ColorConst.success700),
                          ).textSemiboldSM(),
                        )),
                  );
      },
    );
  }
}
