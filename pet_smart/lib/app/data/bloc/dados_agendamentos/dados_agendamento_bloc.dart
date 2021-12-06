//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_smart/app/data/models/agendamento_model.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';
import 'dados_agendamento.dart';

class DadosAgendamentosBloc
    extends Bloc<DadosAgendamentosEvent, DadosAgendamentosState> {
  final PessoaRepository pessoaRepository;

  DadosAgendamentosBloc({@required this.pessoaRepository})
      : assert(pessoaRepository != null);

  @override
  DadosAgendamentosState get initialState => InitialDadosAgendamentosState();

  @override
  Stream<DadosAgendamentosState> mapEventToState(
      DadosAgendamentosEvent event) async* {
    if (event is FetchDadosAgendamentos) {
      yield DadosAgendamentosLoading();
      try {
        final List<AgendamentoModel> agendamentos =
            await pessoaRepository.getDadosAgendamentosUsuario(
                idFornecedor: event.idFornecedor, token: event.token);
        yield DadosAgendamentosLoaded(agendamentos: agendamentos);
      } catch (e) {
        yield DadosAgendamentosError(e: e);
      }
    }
  }
}
