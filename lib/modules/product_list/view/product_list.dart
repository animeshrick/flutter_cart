import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/const/divider_const.dart';
import 'package:flutter_cart/modules/product_list/widget/product_item.dart';

import '../../../const/color_const.dart';
import '../../../extension/hex_color.dart';
import '../../../router/custom_router/custom_route.dart';
import '../../../router/router_name.dart';
import '../../../service/value_handler.dart';
import '../../../storage/local_product_bloc/local_products_bloc.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/custom_button.dart';
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
  final ProductListBloc _productListBloc = ProductListBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _productListBloc..add(GetProductList()),
      child: BlocListener<LocalProductsBloc, LocalProductsState>(
        listener: (context, state) {
          if (state is LocalProductListLoaded) {
            _productListBloc.add(GetProductCount());
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
                        label: CustomText(
                            "${state is ProductListLoaded ? state.productCount : "0"}"),
                        isLabelVisible: ValueHandler().isTextNotEmptyOrNull(
                            state is ProductListLoaded
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
              body: state is ProductListInitial || state is ProductListLoading
                  ? ProductListUtils().buildLoading()
                  : state is ProductListLoaded
                      ? ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.productModel?.items?.products
                                  ?.product?.length ??
                              0,
                          /**/
                          separatorBuilder: (_, __) =>
                              CustomDivider().normalDivider(),
                          itemBuilder: (_, int index) {
                            Product? product = state
                                .productModel?.items?.products?.product
                                ?.elementAt(index);
                            return ProductItem(product: product);
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
