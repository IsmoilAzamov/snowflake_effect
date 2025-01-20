

import '../../../domain/entities/product/product_entity.dart';


sealed class PomMarketState {}

class PomMarketLoadingState extends PomMarketState {}

class PomMarketLoadedState extends PomMarketState {
  List<ProductEntity> products;

  PomMarketLoadedState(this.products);
}

class PomMarketErrorState extends PomMarketState {
  final String message;

  PomMarketErrorState(this.message);
}