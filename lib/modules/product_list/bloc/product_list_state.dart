part of 'product_list_bloc.dart';

class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object?> get props => [];
}

final class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final ProductList productModel;

  const ProductListLoaded(this.productModel);
}

class ProductListError extends ProductListState {
  final String? message;

  const ProductListError(this.message);
}
