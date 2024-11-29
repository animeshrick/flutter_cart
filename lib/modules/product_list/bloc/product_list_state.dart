part of 'product_list_bloc.dart';

class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object?> get props => [];
}

final class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final ProductList? productModel;
  final int? productCount;

  const ProductListLoaded({this.productModel, this.productCount = 0});

  @override
  List<Object?> get props => [productModel, productCount];
}

class ProductListError extends ProductListState {
  final String? message;

  const ProductListError(this.message);
}
