//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';

import 'agendamento.dart';

class AgendamentoBloc extends Bloc<AgendamentoEvent, AgendamentoState> {
  final PessoaRepository pessoaRepository;

  AgendamentoBloc({@required this.pessoaRepository})
      : assert(pessoaRepository != null);

  AgendamentoState get initialState => InitialAgendamentoState();

  @override
  Stream<AgendamentoState> mapEventToState(AgendamentoEvent event) async* {
    if (event is Agendamento) {
      yield AgendamentoLoading();
      try {
        await pessoaRepository.addAgendamento(
            event.tipoAgendamento,
            event.dtAgendamento,
            event.idPet,
            event.idFornecedor,
            event.idUsuario,
            event.token);
        yield AgendamentoLoaded();
      } catch (e) {
        print(e);
        yield AgendamentoError(e: e);
      }
    } else if (event is GetAgendamento) {
      yield AgendamentoLoading();
    }
  }
}
