import 'dart:convert';

import '../../../const/api_url_const.dart';
import '../../../data/api_client/imp/api_repo_imp.dart';
import '../../../data/api_client/repo/api_repo.dart';
import '../../../data/model/api_return_model.dart';
import '../../../extension/logger_extension.dart';
import '../model/product.dart';

class ProductRepo {
  Future<List<Product>> getProducts() async {
    try {
       Map<String, String> headers = {};
      ApiReturnModel? response = await apiRepo().callApi(
          tag: 'Products',
          uri: ApiUrlConst.books,
          method: Method.get,
          headers: headers,
          queryParameters: {});
      if (response?.responseString != null) {
        var v = json.decode(response?.responseString ?? "");
        AppLog.e(v);
        Product products = Product();
        return [];
      }
    } catch (e, stacktrace) {
      AppLog.e(e.toString(), error: e, stackTrace: stacktrace);
    }
    return [];
  }
}
