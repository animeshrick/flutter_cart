import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/modules/product_list/model/product.dart';

import '../../../storage/product_sotrage/product_storage.dart';
import '../repo/product_repo.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepo _apiRepository = ProductRepo();

  ProductListBloc() : super(ProductListInitial()) {
    on<GetProductList>(_onGetProductList);
    on<GetProductCount>(_onGetProductCount);
  }

  Future<void> _onGetProductList(
      GetProductList event, Emitter<ProductListState> emit) async {
    try {
      emit(ProductListLoading());
      final ProductList? mList = await _apiRepository.getProducts();

      emit(ProductListLoaded(productModel: mList ?? ProductList()));

      if (mList?.items?.products?.product?.isNotEmpty == true) {
        add(GetProductCount());
      }
    } catch (e) {
      emit(const ProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }

  Future<void> _onGetProductCount(
      GetProductCount event, Emitter<ProductListState> emit) async {
    try {
      List<Product> localProducts =
          (await ProductStorage.instance.getAllProducts());

      final prevList = state is ProductListLoaded
          ? (state as ProductListLoaded).productModel
          : ProductList();

      emit(ProductListLoaded(
          productCount: localProducts.length, productModel: prevList));
    } catch (e) {
      emit(const ProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }
}
