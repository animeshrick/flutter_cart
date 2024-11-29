import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/const/divider_const.dart';
import 'package:flutter_cart/extension/spacing.dart';
import 'package:flutter_cart/widget/custom_ui.dart';

import '../../../const/color_const.dart';
import '../../../extension/hex_color.dart';
import '../../../extension/logger_extension.dart';
import '../../../service/value_handler.dart';
import '../../../storage/product_sotrage/product_storage.dart';
import '../../../utils/text_utils.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import '../bloc/product_list_bloc.dart';
import '../model/product.dart';
import '../utils/product_list_utils.dart';
import '../widget/product_widget.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductListBloc _newsBloc = ProductListBloc();

  String count = "";

  Future<void> getCountUpdate() async {
    List<Product> list = await ProductStorage.instance.getAllProducts();
    setState(() => count = list.length.toString());

    AppLog.d(list.map((product) => product.displayName).join(" & "),
        tag: "Onion_prd--:");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _newsBloc.add(GetProductList());
      await getCountUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _newsBloc,
      child: BlocListener<ProductListBloc, ProductListState>(
        listener: (context, state) {
          if (state is ProductListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            return Scaffold(
              appBar: CustomAppbar(
                title: "Products",
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Badge(
                        backgroundColor: HexColor.fromHex(ColorConst.error500),
                        label: CustomText(count),
                        isLabelVisible:
                            ValueHandler().isTextNotEmptyOrNull(count),
                        child: CustomIconButton(
                            onPressed: () async {
                              await getCountUpdate();
                            },
                            icon: const Icon(Icons.shopping_cart_outlined))),
                  ),
                ],
              ),
              body: state is ProductListInitial || state is ProductListLoading
                  ? ProductListUtils().buildLoading()
                  : state is ProductListLoaded
                      ? /*ProductBuild(
                          prdList:
                              state.productModel.items?.products?.notc ?? [],
                        )*/
                      ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.productModel.items?.products?.product
                                  ?.length ??
                              0,
                          /**/
                          separatorBuilder: (_, __) =>
                              CustomDivider().normalDivider(),
                          itemBuilder: (_, int index) {
                            Product? product = state
                                .productModel.items?.products?.product
                                ?.elementAt(index);
                            return CustomContainer(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  4.ph,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomContainer(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6)),
                                        borderColor: HexColor.fromHex(
                                            ColorConst.gray400),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 7),
                                        child: CustomNetWorkImageView(
                                          url: product?.productImage ?? "",
                                          height: 48,
                                          width: 48,
                                        ),
                                      ),
                                      10.pw,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextEnum(
                                                  product?.displayName ?? "",
                                                  color: HexColor.fromHex(
                                                      ColorConst.primaryDark))
                                              .textXS(),
                                          CustomTextEnum(
                                                  product?.mfgGroup ?? "",
                                                  color: HexColor.fromHex(
                                                      ColorConst.gray500))
                                              .textXS(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CustomTextEnum(
                                                  "${TextUtils.rupee}${product?.offerPrice.toString() ?? ""}",
                                                  color: HexColor.fromHex(
                                                      ColorConst.primaryDark))
                                              .textMediumSM(),
                                          5.pw,
                                          CustomTextEnum(
                                                  "${TextUtils.rupee}${product?.bBMRP ?? ""}",
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: HexColor.fromHex(
                                                      ColorConst.gray400))
                                              .textXS(),
                                          5.pw,
                                          CustomContainer(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(2)),
                                            color: HexColor.fromHex(
                                                ColorConst.complimentary600),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2),
                                            child: CustomTextEnum(
                                                    "${product?.bBDiscountPercent ?? ""}% Off",
                                                    color: Colors.white)
                                                .textMediumXS(),
                                          ),
                                        ],
                                      ),
                                      ProductCartAddEditToCartButton(
                                          product: product),
                                    ],
                                  ),
                                  4.ph,
                                ],
                              ),
                            );
                          })
                      : state is ProductListError
                          ? Container(color: Colors.red)
                          : Container(color: Colors.yellow),
            );
          },
        ),
      ),
    );
  }
}
