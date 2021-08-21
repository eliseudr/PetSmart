//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  final String cpf;
  final String senha;

  Login({@required this.cpf, @required this.senha})
      : assert(cpf != null && senha != null);
}

class GetPessoa extends LoginEvent {}
