import 'package:my_ihma/client/domain/entities/type/type_entity.dart';

sealed class FilterWidgetState{}

class FilterWidgetInitialState extends FilterWidgetState{}

class FilterWidgetLoadingState extends FilterWidgetState{}

class FilterWidgetLoadedState extends FilterWidgetState{
  final List<TypeEntity> regions;
  final List<TypeEntity> countries;
  final List<TypeEntity> brands;

  FilterWidgetLoadedState({required this.regions, required this.countries, required this.brands});
}

class FilterWidgetErrorState extends FilterWidgetState{
  final String message;

  FilterWidgetErrorState(this.message,);
}