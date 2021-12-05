//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AgendamentoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Agendamento extends AgendamentoEvent {
  final String tipoAgendamento;
  final String dtAgendamento;
  final int idPet;
  final int idFornecedor;
  final int idUsuario;
  final String token;

  Agendamento(
      {@required this.tipoAgendamento,
      @required this.dtAgendamento,
      @required this.idPet,
      @required this.idFornecedor,
      @required this.idUsuario,
      @required this.token});
}

class GetAgendamento extends AgendamentoEvent {}
