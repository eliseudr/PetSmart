//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_smart/app/data/models/pet_model.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';

import 'dados__pet_pessoa.dart';

class DadosPetPessoaBloc
    extends Bloc<DadosPetPessoaEvent, DadosPetPessoaState> {
  final PessoaRepository pessoaRepository;

  DadosPetPessoaBloc({@required this.pessoaRepository})
      : assert(pessoaRepository != null);

  @override
  DadosPetPessoaState get initialState => InitialDadosPetPessoaState();

  @override
  Stream<DadosPetPessoaState> mapEventToState(
      DadosPetPessoaEvent event) async* {
    if (event is FetchDadosPetPessoa) {
      yield DadosPetPessoaLoading();
      try {
        final List<PetModel> pets = await pessoaRepository.getDadosPetUsuario(
            idPessoa: event.idPessoa, token: event.token);
        yield DadosPetPessoaLoaded(pets: pets);
      } catch (e) {
        yield DadosPetPessoaError(e: e);
      }
    }
  }
}
