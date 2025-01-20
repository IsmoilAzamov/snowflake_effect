


import 'package:my_ihma/client/domain/entities/filter/filter_entity.dart';

sealed class PomMarketEvent {}

class PomMarketLoadEvent extends PomMarketEvent {
  final FilterEntity filter;

  PomMarketLoadEvent({required this.filter});
}

class InitPomMarketEvent extends PomMarketEvent {}



