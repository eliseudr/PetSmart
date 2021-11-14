//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class DadosPessoaEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDadosPessoa extends DadosPessoaEvent {
  final int idPessoa;
  final String token;

  FetchDadosPessoa({@required this.idPessoa, @required this.token})
      : assert(idPessoa != null && token != null);
}
