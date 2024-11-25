import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cart/extension/logger_extension.dart';
import 'package:flutter_cart/modules/product_list/model/product.dart';

import '../repo/product_repo.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

/*
class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {
    on<ProductListEvent>((event, emit) {
      final ProductRepo _apiRepository = ProductRepo();

      on<GetProductList>((event, emit) async {
        try {
          AppLog.d("message1");
          emit(ProductListLoading());
          AppLog.d("message2");
          final mList = await _apiRepository.getProducts();
          emit(ProductListLoaded(mList??ProductList()));
        } on NetworkError {
          AppLog.d("message3");
          emit(ProductListError("Failed to fetch data. is your device online?"));
        }
      });
    });
  }
}*/


class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepo _apiRepository = ProductRepo();

  ProductListBloc() : super(ProductListInitial()) {
    on<GetProductList>(_onGetProductList); // Handle `GetProductList` event
  }

  Future<void> _onGetProductList(
      GetProductList event, Emitter<ProductListState> emit) async {
    try {
      AppLog.d("message1");
      emit(ProductListLoading()); // Emit loading state
      AppLog.d("message2");
      final mList = await _apiRepository.getProducts();
      emit(ProductListLoaded(mList ?? ProductList())); // Emit loaded state
    } catch (e) {
      AppLog.d("message3");
      emit(ProductListError("Failed to fetch data. Is your device online?")); // Emit error state
    }
  }
}
