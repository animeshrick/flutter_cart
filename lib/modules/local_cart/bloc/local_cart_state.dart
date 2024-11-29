part of 'local_cart_bloc.dart';

class LocalCartState extends Equatable {
  const LocalCartState();

  @override
  List<Object?> get props => [];
}

final class LocalCartInitial extends LocalCartState {
  @override
  List<Object> get props => [];
}

class LocalCartLoading extends LocalCartState {}

class LocalCartLoaded extends LocalCartState {
  final List<Product>? productList;
  final num? totalPayableAmount;
  final num? totalSavings;
  final num? totalItems;

  const LocalCartLoaded({
    this.productList,
    this.totalPayableAmount = 0,
    this.totalSavings = 0,
    this.totalItems = 0,
  });

  @override
  List<Object?> get props => [productList];
}

class LocalCartError extends LocalCartState {
  final String? message;

  const LocalCartError(this.message);
}
