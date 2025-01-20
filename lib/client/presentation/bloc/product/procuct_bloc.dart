import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ihma/client/domain/entities/product/product_entity.dart';
import 'package:my_ihma/client/presentation/bloc/product/product_event.dart';
import 'package:my_ihma/client/presentation/bloc/product/product_state.dart';

import '../../../../core/resources/datastate.dart';
import '../../../domain/repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc(this._productRepository) : super(ProductLoadingState()) {
    on<ProductLoadEvent>(_load);
  }

  Future<void> _load(ProductLoadEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());

    try {
      // Run both API calls in parallel
      final results = await Future.wait([
        _productRepository.getById(productId: event.id),
        _productRepository.getSimilarList(productId: event.id, page: 1, pageSize: 2),
      ]);

      // Destructure results
      final productResult = results[0] as DataState;
      final similarResult = results[1] as DataState;

      if (productResult is DataSuccess && productResult.data != null) {
        // You can use similarResult here if needed
        List<ProductEntity> similarProducts = similarResult is DataSuccess ? similarResult.data : [];

        emit(ProductLoadedState(
          product: productResult.data!,
          similarProducts: similarProducts,
        ));
        return;
      } else if (productResult is DataError) {
        emit(ProductErrorState(
          productResult.error?.message ?? "something_went_wrong".tr(),
        ));
        return;
      }

      emit(ProductErrorState("something_went_wrong".tr()));
    } catch (e, stackTrace) {
      // Log error if you have a logging service
      // logger.error('Failed to load product', e, stackTrace);

      emit(ProductErrorState("something_went_wrong".tr()));
    }
  }
}
