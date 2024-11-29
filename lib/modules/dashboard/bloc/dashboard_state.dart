part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

final class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final int? productCount;

  const DashboardLoaded({this.productCount = 0});

  @override
  List<Object?> get props => [productCount];
}

class DashboardError extends DashboardState {
  final String? message;

  const DashboardError(this.message);
}
