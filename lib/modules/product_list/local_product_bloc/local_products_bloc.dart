import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../storage/product_sotrage/product_storage.dart';
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
      // emit(LocalProductListLoading());

      List<Product> productList =
          await ProductStorage.instance.getAllProducts();

      ProductList productListWrapper = ProductList();
      productListWrapper.items ??= Items();
      productListWrapper.items?.products ??= Products();
      productListWrapper.items?.products?.product ??= [];

      productListWrapper.items!.products?.product?.addAll(productList);

      emit(LocalProductsInitial());
      emit(LocalProductListLoaded(productListWrapper));
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }

  Future<void> _onSingleAddLocalProduct(
      AddSingleLocalProduct event, Emitter<LocalProductsState> emit) async {
    try {
      List<Product> _localProductList =
          await ProductStorage.instance.getAllProducts();
      if (_localProductList
          .where((element) => element.productId == event.product.productId)
          .isEmpty) {
        event.product.bBMinQty = 1;
        await ProductStorage.instance.addUpdateProduct(event.product);
        add(GetLocalProductList());
      } else {
        Product filteredProduct = _localProductList
            .where((element) => element.productId == event.product.productId)
            .first;
        filteredProduct.bBMinQty = (filteredProduct.bBMinQty ?? 0) + 1;

        await ProductStorage.instance.addUpdateProduct(filteredProduct);

        add(GetLocalProductList());
      }

      /*emit(LocalProductListLoading());

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
          type: ToastificationType.success);*/
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }

  FutureOr<void> _onSingleRemoveLocalProduct(
      RemoveSingleLocalProduct event, Emitter<LocalProductsState> emit) async {
    try {
      List<Product> _localProductList =
          await ProductStorage.instance.getAllProducts();
      if (_localProductList
          .where((element) => element.productId == event.product.productId)
          .isNotEmpty) {
        Product filteredProduct = _localProductList
            .where((element) => element.productId == event.product.productId)
            .first;

        if (filteredProduct.bBMinQty == 1) {
          await ProductStorage.instance
              .deleteProduct(event.product.productId ?? "");
        } else {
          filteredProduct.bBMinQty = (filteredProduct.bBMinQty ?? 0) - 1;
          await ProductStorage.instance.addUpdateProduct(filteredProduct);
        }

        add(GetLocalProductList());
      }

      /*emit(LocalProductListLoading());

      List<Product> list = await ProductStorageHive.instance.getAllProducts();

      String pID =
          ValueHandler().stringify(event.product.productId ?? "") ?? "";
      await ProductStorageHive.instance.deleteProduct(pID);
      list.removeWhere((Product prd) => prd.productId == pID);
      ProductList productList = ProductList();
      productList.items?.products?.product = list;

      emit(LocalProductListLoaded(productList));*/
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }

  Future<void> _onClearAllLocalProduct(
      ClearAllLocalProduct event, Emitter<LocalProductsState> emit) async {
    try {
      emit(LocalProductListLoading());

      await ProductStorage.instance.clearAllProducts();
      ProductList productList = ProductList();
      productList.items?.products?.product = [];
      emit(LocalProductListLoaded(productList));
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }
}
