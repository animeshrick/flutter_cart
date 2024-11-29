part of 'local_products_bloc.dart';

class LocalProductsState extends Equatable {
  const LocalProductsState();

  @override
  List<Object?> get props => [];
}

final class LocalProductsInitial extends LocalProductsState {
  final ProductList? productModel;

  LocalProductsInitial({this.productModel});
}

class LocalProductListLoading extends LocalProductsState {}

class LocalProductListLoaded extends LocalProductsState {
  final ProductList productModel;

  const LocalProductListLoaded(this.productModel);
}

class LocalProductListError extends LocalProductsState {
  final String? message;

  const LocalProductListError(this.message);
}
