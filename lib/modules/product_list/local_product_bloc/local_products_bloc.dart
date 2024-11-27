import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../storage/product_sotrage/product_hive.dart';
import '../model/product.dart';

part 'local_products_event.dart';
part 'local_products_state.dart';

class LocalProductsBloc extends Bloc<LocalProductsEvent, LocalProductsState> {
  LocalProductsBloc() : super(LocalProductsInitial()) {
    on<GetLocalProductList>(_onGetLocalProductList);
  }

  Future<void> _onGetLocalProductList(
      GetLocalProductList event, Emitter<LocalProductsState> emit) async {
    try {
      emit(LocalProductListLoading());

      List<Product> _tempList = [];
      List<Product> list = await ProductStorageHive().getAllProducts();
      _tempList.addAll(list);

      ProductList _productList = ProductList();
      _productList.items?.products?.notc = _tempList;
      emit(LocalProductListLoaded(_productList));
    } catch (e) {
      emit(const LocalProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }
}