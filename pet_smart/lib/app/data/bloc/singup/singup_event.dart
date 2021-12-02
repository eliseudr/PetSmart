//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class SingupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Singup extends SingupEvent {
  final String email;
  final String nome;
  final String cpf;
  final String senha;
  final int cliente;

  Singup(
      {@required this.email,
      @required this.nome,
      @required this.cpf,
      @required this.senha,
      @required this.cliente})
      : assert(email != null &&
            nome != null &&
            cpf != null &&
            senha != null &&
            cliente != null);
}

class GetPessoa extends SingupEvent {}
