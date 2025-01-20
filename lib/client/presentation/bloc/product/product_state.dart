
import 'package:my_ihma/client/domain/entities/product/product_entity.dart';

sealed class ProductState{}

class ProductInitialState extends ProductState{}

class ProductLoadingState extends ProductState{}

class ProductLoadedState extends ProductState{
  final ProductEntity product;
  final List<ProductEntity> similarProducts;
  ProductLoadedState({required this.product, required this.similarProducts});
}

class ProductErrorState extends ProductState{
  final String message;

  ProductErrorState(this.message,);
}