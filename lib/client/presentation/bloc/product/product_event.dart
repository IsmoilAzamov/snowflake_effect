sealed class ProductEvent {}

class ProductLoadEvent extends ProductEvent {
  final String id;

  ProductLoadEvent(this.id);
}
