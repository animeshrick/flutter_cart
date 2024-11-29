import 'package:flutter/material.dart';

import '../../../extension/logger_extension.dart';
import '../model/product.dart';

class ProductListUtils {
  Widget buildLoading() => Center(child: CircularProgressIndicator());

  bool checkIfProductContainInCart(
      {required List<Product> allProductList, required String productId}) {
    try {
      return allProductList
          .where((element) => element.productId == productId)
          .isNotEmpty;
    } catch (e, stacktrace) {
      AppLog.e(e.toString(), error: e, stackTrace: stacktrace);
      return false;
    }
  }

  Product? filterCartProduct(
      {required List<Product> allProductList, required String productId}) {
    try {
      return allProductList
          .firstWhere((element) => element.productId == productId);
    } catch (e) {
      return null;
    }
  }
}
