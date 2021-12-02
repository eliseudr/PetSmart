//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_smart/app/data/models/pessoa_model.dart';
import 'package:pet_smart/app/data/models/usuario_logado_model.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final PessoaModel pessoa;

  LoginLoaded({@required this.pessoa}) : assert(pessoa != null);
}

class LoginError extends LoginState {
  final Exception e;

  LoginError({@required this.e}) : assert(e != null);
}

class PessoaLoaded extends LoginState {
  final UsuarioLogadoModel pessoa;

  PessoaLoaded({@required this.pessoa});
}
