//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:pet_smart/app/data/models/pet_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class DadosPetPessoaState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialDadosPetPessoaState extends DadosPetPessoaState {}

class DadosPetPessoaLoading extends DadosPetPessoaState {}

class DadosPetPessoaLoaded extends DadosPetPessoaState {
  final List<PetModel> pets;

  DadosPetPessoaLoaded({@required this.pets}) : assert(pets != null);
}

class DadosPetPessoaError extends DadosPetPessoaState {
  final Exception e;

  DadosPetPessoaError({@required this.e}) : assert(e != null);
}
