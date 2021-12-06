//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:pet_smart/app/data/models/agendamento_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class DadosAgendamentosState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialDadosAgendamentosState extends DadosAgendamentosState {}

class DadosAgendamentosLoading extends DadosAgendamentosState {}

class DadosAgendamentosLoaded extends DadosAgendamentosState {
  final List<AgendamentoModel> agendamentos;

  DadosAgendamentosLoaded({@required this.agendamentos})
      : assert(agendamentos != null);
}

class DadosAgendamentosError extends DadosAgendamentosState {
  final Exception e;

  DadosAgendamentosError({@required this.e}) : assert(e != null);
}
