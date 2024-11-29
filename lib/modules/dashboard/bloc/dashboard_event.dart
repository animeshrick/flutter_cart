part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class GetProductListCount extends DashboardEvent {
  @override
  List<Object?> get props => [];
}
