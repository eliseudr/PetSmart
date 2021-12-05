//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AgendamentoState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAgendamentoState extends AgendamentoState {}

class AgendamentoLoading extends AgendamentoState {}

class AgendamentoLoaded extends AgendamentoState {}

class AgendamentoError extends AgendamentoState {
  final Exception e;

  AgendamentoError({@required this.e});
}

class PessoaLoaded extends AgendamentoState {}
