part of 'local_products_bloc.dart';

sealed class LocalProductsEvent extends Equatable {
  const LocalProductsEvent();
}

class GetLocalProductList extends LocalProductsEvent {
  @override
  List<Object?> get props => [];
}
