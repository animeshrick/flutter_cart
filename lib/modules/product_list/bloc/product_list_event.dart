part of 'product_list_bloc.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent();
}

class GetProductList extends ProductListEvent {
  @override
  List<Object?> get props => [];
}
