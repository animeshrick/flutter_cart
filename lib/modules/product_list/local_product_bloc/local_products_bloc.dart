import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/service/value_handler.dart';
import 'package:flutter_cart/utils/pop_up_items.dart';
import 'package:toastification/toastification.dart';

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

  /*Future<void> _onGetLocalProductList(
      GetLocalProductList event, Emitter<LocalProductsState> emit) async {
    try {
      emit(LocalProductListLoading());

      List<Product> tempList = [];
      List<Product> list = await ProductStorageHive.instance.getAllProducts();
      tempList.addAll(list);

      ProductList productList = ProductList();
      productList.items?.products?.notc = tempList;
      emit(LocalProductListLoaded(productList));
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }*/

  Future<void> _onGetLocalProductList(
      GetLocalProductList event, Emitter<LocalProductsState> emit) async {
    try {
      emit(LocalProductListLoading());

      List<Product> productList =
          await ProductStorageHive.instance.getAllProducts();

      ProductList productListWrapper = ProductList();
      productListWrapper.items?.products?.notc = productList;

      emit(LocalProductListLoaded(productListWrapper));
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }

  Future<void> _onSingleAddLocalProduct(
      AddSingleLocalProduct event, Emitter<LocalProductsState> emit) async {
    try {
      emit(LocalProductListLoading());

      List<Product> tempList = [];
      await ProductStorageHive.instance.saveProduct(event.product);
      tempList.add(event.product);
      ProductList productList = ProductList();
      productList.items?.products?.notc = tempList;

      emit(LocalProductListLoaded(productList));

      String? pName = tempList
          .firstWhere(
              (Product product) => product.productId == event.product.productId)
          .displayName;

      PopUpItems().toastfy("$pName successfully added!", Colors.green,
          type: ToastificationType.success);
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
      ProductList productList = ProductList();
      productList.items?.products?.notc = list;

      emit(LocalProductListLoaded(productList));
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
      ProductList productList = ProductList();
      productList.items?.products?.notc = [];
      emit(LocalProductListLoaded(productList));
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }
}
