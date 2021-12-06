//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class DadosAgendamentosEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDadosAgendamentos extends DadosAgendamentosEvent {
  final int idFornecedor;
  final String token;

  FetchDadosAgendamentos({@required this.idFornecedor, @required this.token})
      : assert(idFornecedor != null && token != null);
}
