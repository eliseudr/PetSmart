//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_smart/app/data/bloc/dados_pessoa/dados_pessoa.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';

class DadosPessoaBloc extends Bloc<DadosPessoaEvent, DadosPessoaState> {
  final PessoaRepository pessoaRepository;

  DadosPessoaBloc({@required this.pessoaRepository})
      : assert(pessoaRepository != null);

  @override
  DadosPessoaState get initialState => InitialDadosPessoaState();

  @override
  Stream<DadosPessoaState> mapEventToState(DadosPessoaEvent event) async* {
    if (event is FetchDadosPessoa) {
      yield DadosPessoaLoading();
      try {
        final pessoa =
            await pessoaRepository.getDadosUsuario(event.idPessoa, event.token);
        yield DadosPessoaLoaded(pessoa: pessoa);
      } catch (e) {
        yield DadosPessoaError(e: e);
      }
    }
  }
}
