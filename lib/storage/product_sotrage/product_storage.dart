import 'package:flutter_cart/extension/logger_extension.dart';
import 'package:flutter_cart/service/value_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../modules/product_list/model/product.dart';
import '../app_hive.dart';

class ProductStorage {
  ProductStorage._();

  static final ProductStorage _productLocalSote = ProductStorage._();

  static ProductStorage get instance => _productLocalSote;

  static const String _productBox = AppHive.productBoxKey;

  BoxCollection? collection;

  Future<void> _initializeHive() async {
    collection = await AppHive.getHiveCollection();
  }

  // Open the Hive box
  Future<Box> _openBox() async {
    await _initializeHive();
    return await Hive.openBox<Map>(_productBox);
  }

  // Save a single product
  Future<void> addUpdateProduct(Product? product) async {
    if (ValueHandler().isTextNotEmptyOrNull(product?.productId)) {
      // AppLog.t("${product?.displayName}--${product?.offerPrice}--${product?.productId}", tag: "saveProduct");
      final box = await _openBox();
      await box.put(product?.productId ?? "", product?.toJson());
    }
  }

  // Retrieve all products
  Future<List<Product>> getAllProducts() async {
    final box = await _openBox();
    return box.values.map((map) {
      final productMap = Map<String, dynamic>.from(map as Map);
      // AppLog.t(productMap["DisplayName"], tag: "getAllProducts");
      return Product.fromJson(productMap);
    }).toList();
  }

  // Get a single product by ID
/*  Future<Product?> getProductById(String id) async {
    AppLog.t(id, tag: "getProductById");

    final box = await _openBox();
    final productMap = box.get(id);
    if (productMap != null) {
      return Product.fromJson(productMap as Map<String, dynamic>);
    }
    return null;
  }*/

  // Delete a single product by ID
  Future<void> deleteProduct(String id) async {
    final box = await _openBox();
    await box.delete(id);
    // AppLog.t(id, tag: "deleteProduct");
  }

  // Clear all products
  Future<void> clearAllProducts() async {
    final box = await _openBox();
    await box.clear();
    AppLog.t("clearAllProducts");
  }
}
