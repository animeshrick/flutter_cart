import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../storage/product_sotrage/product_storage.dart';
import '../../product_list/model/product.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>(_getProductListCount);
  }

  FutureOr<void> _getProductListCount(
      DashboardEvent event, Emitter<DashboardState> emit) async {
    try {
      emit(DashboardLoading());
      List<Product> productList =
          await ProductStorage.instance.getAllProducts();
      emit(DashboardLoaded(productCount: productList.length));
    } catch (e) {
      emit(
          const DashboardError("Failed to fetch data. Is your device online?"));
    }
  }
}
