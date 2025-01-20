import 'package:my_ihma/client/domain/entities/type/type_entity.dart';

sealed class RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterLoadedState extends RegisterState {
  List<TypeEntity> documentTypes;

  RegisterLoadedState(this.documentTypes);
}

class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState(this.message);
}