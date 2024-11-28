import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/service/value_handler.dart';

import '../../../storage/product_sotrage/product_hive.dart';
import '../model/product.dart';

part 'local_products_event.dart';
part 'local_products_state.dart';

class LocalProductsBloc extends Bloc<LocalProductsEvent, LocalProductsState> {
  LocalProductsBloc() : super(LocalProductsInitial()) {
    on<GetLocalProductList>(_onGetLocalProductList);
    on<AddSingleLocalProduct>(_onSingleAddLocalProduct);
    on<RemoveSingleLocalProduct>(_onSingleRemoveLocalProduct);
    on<ClearAllLocalProduct>(_onClearAllLocalProduct);
  }

  Future<void> _onGetLocalProductList(
      GetLocalProductList event, Emitter<LocalProductsState> emit) async {
    try {
      emit(LocalProductListLoading());

      List<Product> _tempList = [];
      List<Product> list = await ProductStorageHive.instance.getAllProducts();
      _tempList.addAll(list);

      ProductList _productList = ProductList();
      _productList.items?.products?.notc = _tempList;
      emit(LocalProductListLoaded(_productList));
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }

  Future<void> _onSingleAddLocalProduct(
      AddSingleLocalProduct event, Emitter<LocalProductsState> emit) async {
    try {
      emit(LocalProductListLoading());

      List<Product> _tempList = [];
      await ProductStorageHive.instance.saveProduct(event.product);
      _tempList.add(event.product);
      ProductList _productList = ProductList();
      _productList.items?.products?.notc = _tempList;

      emit(LocalProductListLoaded(_productList));
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }

  FutureOr<void> _onSingleRemoveLocalProduct(
      RemoveSingleLocalProduct event, Emitter<LocalProductsState> emit) async {
    try {
      emit(LocalProductListLoading());

      List<Product> list = await ProductStorageHive.instance.getAllProducts();

      String pID =
          ValueHandler().stringify(event.product.productId ?? "") ?? "";
      await ProductStorageHive.instance.deleteProduct(pID);
      list.removeWhere((Product prd) => prd.productId == pID);
      ProductList _productList = ProductList();
      _productList.items?.products?.notc = list;

      emit(LocalProductListLoaded(_productList));
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }

  Future<void> _onClearAllLocalProduct(
      ClearAllLocalProduct event, Emitter<LocalProductsState> emit) async {
    try {
      emit(LocalProductListLoading());

      await ProductStorageHive.instance.clearAllProducts();
      ProductList _productList = ProductList();
      _productList.items?.products?.notc = [];
      emit(LocalProductListLoaded(_productList));
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }
}
