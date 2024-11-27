import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/modules/product_list/view/product_build.dart';

import '../../../extension/logger_extension.dart';
import '../bloc/product_list_bloc.dart';
import '../utils/product_list_utils.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductListBloc _newsBloc = ProductListBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _newsBloc.add(GetProductList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _newsBloc,
      child: BlocListener<ProductListBloc, ProductListState>(
        listener: (context, state) {
          AppLog.d("message_onion");
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
              appBar: AppBar(),
              body: state is ProductListInitial || state is ProductListLoading
                  ? ProductListUtils().buildLoading()
                  : state is ProductListLoaded
                      ? ProductBuild(
                          prdList:
                              state.productModel.items?.products?.notc ?? [],
                        )
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
