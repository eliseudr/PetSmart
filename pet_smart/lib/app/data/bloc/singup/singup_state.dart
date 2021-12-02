//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_smart/app/data/models/pessoa_model.dart';
import 'package:pet_smart/app/data/models/usuario_logado_model.dart';

@immutable
abstract class SingupState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSingupState extends SingupState {}

class SingupLoading extends SingupState {}

class SingupLoaded extends SingupState {}

class SingupError extends SingupState {
  final Exception e;

  SingupError({@required this.e});
}

class PessoaLoaded extends SingupState {}
