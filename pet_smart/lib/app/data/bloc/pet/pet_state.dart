//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class PetState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialPetState extends PetState {}

class PetLoading extends PetState {}

class PetLoaded extends PetState {}

class PetError extends PetState {
  final Exception e;

  PetError({@required this.e});
}

class PessoaLoaded extends PetState {}
