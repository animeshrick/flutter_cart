import 'package:flutter_cart/extension/logger_extension.dart';
import 'package:flutter_cart/service/value_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../modules/product_list/model/product.dart';

class ProductStorageHive {
  ProductStorageHive._();

  static final ProductStorageHive _productLocalSote = ProductStorageHive._();

  static ProductStorageHive get instance => _productLocalSote;

  static const String _productBox = 'productsBox';

  Future<void> initializeHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    // AppLog.t(dir.path, tag: "initializeHive");
    await Hive.initFlutter();
    await Hive.openBox<Map>(_productBox);
  }

  // Open the Hive box
  Future<Box> _openBox() async {
    await initializeHive();
    return await Hive.openBox<Map>(_productBox);
  }

  // Save a single product
  Future<void> saveProduct(Product? product) async {
    if (ValueHandler().isTextNotEmptyOrNull(product?.productId)) {
      AppLog.t(
          "${product?.displayName}--${product?.offerPrice}--${product?.productId}",
          tag: "saveProduct");
      final box = await _openBox();
      await box.put(product?.productId, product?.toJson());
    }
  }

  // Retrieve all products
  Future<List<Product>> getAllProducts() async {
    AppLog.t("getAllProducts");
    final box = await _openBox();
    return box.values.map((map) {
      final productMap = Map<String, dynamic>.from(map as Map);
      return Product.fromJson(productMap);
    }).toList();
  }

  // Get a single product by ID
  Future<Product?> getProductById(String id) async {
    AppLog.t(id, tag: "getProductById");

    final box = await _openBox();
    final productMap = box.get(id);
    if (productMap != null) {
      return Product.fromJson(productMap as Map<String, dynamic>);
    }
    return null;
  }

  // Delete a single product by ID
  Future<void> deleteProduct(String id) async {
    final box = await _openBox();
    await box.delete(id);
    AppLog.t(id, tag: "deleteProduct");
  }

  // Clear all products
  Future<void> clearAllProducts() async {
    final box = await _openBox();
    await box.clear();
    AppLog.t("clearAllProducts");
  }

  bool checkIfProductContainInLocal(
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
}
