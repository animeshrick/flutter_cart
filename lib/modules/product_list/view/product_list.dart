import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/extension/spacing.dart';
import 'package:toastification/toastification.dart';

import '../../../const/color_const.dart';
import '../../../extension/hex_color.dart';
import '../../../extension/logger_extension.dart';
import '../../../service/value_handler.dart';
import '../../../storage/product_sotrage/product_hive.dart';
import '../../../utils/pop_up_items.dart';
import '../../../utils/screen_utils.dart';
import '../../../utils/text_utils.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import '../bloc/product_list_bloc.dart';
import '../model/product.dart';
import '../utils/product_list_utils.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductListBloc _newsBloc = ProductListBloc();

  String count = "";

  Future<void> getCountUpdate() async {
    List<Product> list = await ProductStorageHive.instance.getAllProducts();
    setState(() => count = list.length.toString());

    AppLog.d(list.map((product) => product.displayName).join(" & "), tag: "Onion_prd--:");
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
                    padding: EdgeInsets.only(right: 17),
                    child: Badge(
                        backgroundColor: HexColor.fromHex(ColorConst.error500),
                        label: CustomText(count),
                        isLabelVisible:  ValueHandler().isTextNotEmptyOrNull(count),
                        child: CustomIconButton(
                            onPressed: () async {
                              await  getCountUpdate();
                            },
                            icon: Icon(Icons.shopping_cart_outlined))),
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
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: state
                                  .productModel.items?.products?.notc?.length ??
                              0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15),
                          itemBuilder: (_, int index) {
                            Product? product = state
                                .productModel.items?.products?.notc
                                ?.elementAt(index);
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: ScreenUtils.aw() * 0.4,
                                            child: CustomTextEnum(
                                                    product?.displayName ?? "")
                                                .textSM()),
                                        5.ph,
                                        CustomTextEnum(
                                                "${TextUtils.rupee}${product?.offerPrice.toString() ?? " "}")
                                            .textSemiboldSM(),
                                      ],
                                    ),
                                  ],
                                ),

                                customCartButton(product: product),
                                /*CustomGOEButton(
                                    backGroundColor: Colors.green,
                                    radius: 8,
                                    child: const CustomText("Add",
                                        color: Colors.white),
                                    onPressed: () async {
                                      PopUpItems().toastfy(
                                          "${product?.displayName ?? ""} added successfully!",
                                          HexColor.fromHex(
                                              ColorConst.success200),
                                          type: ToastificationType.success);
                                      await ProductStorageHive.instance
                                          .saveProduct(product ?? Product());

                                        await getCountUpdate();

                                    }),*/
                              ],
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
