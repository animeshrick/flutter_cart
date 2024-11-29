import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cart/service/value_handler.dart';

import '../../../storage/product_sotrage/product_storage.dart';
import '../../product_list/model/product.dart';

part 'local_cart_event.dart';
part 'local_cart_state.dart';

class LocalCartBloc extends Bloc<LocalCartEvent, LocalCartState> {
  LocalCartBloc() : super(LocalCartInitial()) {
    on<LocalCartEvent>(_getCartProductList);
  }

  FutureOr<void> _getCartProductList(
      LocalCartEvent event, Emitter<LocalCartState> emit) async {
    try {
      emit(LocalCartLoading());
      List<Product> productList =
          await ProductStorage.instance.getAllProducts();

      double calculateTotalPayableAmount() {
        return productList.fold(0.0, (sum, product) {
          final int qty = product.bBMinQty ?? 0;
          final num offerPrice =
              product.offerPrice ?? 0.0;
          return ValueHandler().dp(val:sum + (offerPrice * qty),places: 2);
        });
      }

      double calculateTotalSavings() {
        final totalPayableAmount = calculateTotalPayableAmount();
        final totalMRP = productList.fold(0.0, (sum, product) {
          final int qty = product.bBMinQty ?? 0; // Default to 0 if null
          final num mrp = product.bBMRP ?? 0.0; // Default to 0 if null
          return sum + (mrp * qty);
        });
        return ValueHandler().dp(val:totalMRP - totalPayableAmount,places: 2);
      }

      emit(LocalCartLoaded(
        productList: productList,
        totalItems: productList.length,
        totalPayableAmount: calculateTotalPayableAmount(),
        totalSavings: calculateTotalSavings(),
      ));
    } catch (e) {
      emit(
          const LocalCartError("Failed to fetch data. Is your device online?"));
    }
  }
}
