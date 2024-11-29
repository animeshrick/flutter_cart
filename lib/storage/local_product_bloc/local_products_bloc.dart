import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/const/color_const.dart';
import 'package:flutter_cart/extension/hex_color.dart';
import 'package:toastification/toastification.dart';

import '../../../storage/product_sotrage/product_storage.dart';
import '../../../utils/pop_up_items.dart';
import '../../modules/product_list/model/product.dart';

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

      String? pName = _localProductList
          .firstWhere(
              (Product product) => product.productId == event.product.productId)
          .displayName;

      PopUpItems().toastfy(
          "$pName successfully added!", HexColor.fromHex(ColorConst.success50),
          type: ToastificationType.success);
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

      String? pName = _localProductList
          .firstWhere(
              (Product product) => product.productId == event.product.productId)
          .displayName;

      PopUpItems().toastfy("$pName successfully removed!",
          HexColor.fromHex(ColorConst.complimentary50),
          type: ToastificationType.info);
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
      PopUpItems().toastfy(
          "Cart cleared successfully!", HexColor.fromHex(ColorConst.error50),
          type: ToastificationType.error);
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }
}
