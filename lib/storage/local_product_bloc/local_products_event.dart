part of 'local_products_bloc.dart';

sealed class LocalProductsEvent extends Equatable {
  const LocalProductsEvent();
}

class GetLocalProductList extends LocalProductsEvent {
  @override
  List<Object?> get props => [];
}

class AddSingleLocalProduct extends LocalProductsEvent {
  final Product product;

  const AddSingleLocalProduct({required this.product});

  @override
  List<Object?> get props => [product];
}

class RemoveSingleLocalProduct extends LocalProductsEvent {
  final Product product;

  const RemoveSingleLocalProduct({required this.product});

  @override
  List<Object?> get props => [product];
}

class ClearAllLocalProduct extends LocalProductsEvent {
  @override
  List<Object?> get props => [];
}
