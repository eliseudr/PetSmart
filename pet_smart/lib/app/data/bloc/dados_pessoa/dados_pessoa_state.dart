//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:pet_smart/app/data/models/pessoa_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class DadosPessoaState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialDadosPessoaState extends DadosPessoaState {}

class DadosPessoaLoading extends DadosPessoaState {}

class DadosPessoaLoaded extends DadosPessoaState {
  final PessoaModel pessoa;

  DadosPessoaLoaded({@required this.pessoa}) : assert(pessoa != null);
}

class DadosPessoaError extends DadosPessoaState {
  final Exception e;

  DadosPessoaError({@required this.e}) : assert(e != null);
}
