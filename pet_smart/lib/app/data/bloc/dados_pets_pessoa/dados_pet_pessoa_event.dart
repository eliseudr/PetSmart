//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class DadosPetPessoaEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDadosPetPessoa extends DadosPetPessoaEvent {
  final int idPessoa;
  final String token;

  FetchDadosPetPessoa({@required this.idPessoa, @required this.token})
      : assert(idPessoa != null && token != null);
}
