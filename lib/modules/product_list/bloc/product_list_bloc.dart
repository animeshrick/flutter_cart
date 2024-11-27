import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/modules/product_list/model/product.dart';

import '../repo/product_repo.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepo _apiRepository = ProductRepo();

  ProductListBloc() : super(ProductListInitial()) {
    on<GetProductList>(_onGetProductList);
  }

  Future<void> _onGetProductList(
      GetProductList event, Emitter<ProductListState> emit) async {
    try {
      emit(ProductListLoading());
      final mList = await _apiRepository.getProducts();
      emit(ProductListLoaded(mList ?? ProductList()));
    } catch (e) {
      emit(const ProductListError(
          "Failed to fetch data. Is your device online?"));
    }
  }
}
