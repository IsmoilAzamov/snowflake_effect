import 'package:my_ihma/client/domain/entities/application_module/application_module_entity.dart';

sealed class ApplicationsState {}

class ApplicationsLoadingState extends ApplicationsState {}

class ApplicationsLoadedState extends ApplicationsState {
  List<ApplicationModuleEntity> products;

  ApplicationsLoadedState(this.products);
}

class ApplicationsErrorState extends ApplicationsState {
  final String message;

  ApplicationsErrorState(this.message);
}