part of 'local_cart_bloc.dart';

sealed class LocalCartEvent extends Equatable {
  const LocalCartEvent();
}

class GetCartProductList extends LocalCartEvent {
  @override
  List<Object?> get props => [];
}

