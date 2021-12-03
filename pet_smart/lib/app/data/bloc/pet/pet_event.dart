//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class PetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Pet extends PetEvent {
  final String apelido;
  final String nascimento;
  final String raca;
  final int idUsuario;
  final String token;

  Pet(
      {@required this.apelido,
      @required this.nascimento,
      @required this.raca,
      @required this.idUsuario,
      @required this.token});
}

class GetPessoa extends PetEvent {}
