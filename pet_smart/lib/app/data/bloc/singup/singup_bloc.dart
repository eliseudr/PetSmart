//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:pet_smart/app/data/bloc/singup/singup_event.dart';
import 'package:pet_smart/app/data/bloc/singup/singup_state.dart';
import 'package:pet_smart/app/data/models/pessoa_model.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';

class SingupBloc extends Bloc<SingupEvent, SingupState> {
  final PessoaRepository pessoaRepository;

  SingupBloc({@required this.pessoaRepository})
      : assert(pessoaRepository != null);

  SingupState get initialState => InitialSingupState();

  @override
  Stream<SingupState> mapEventToState(SingupEvent event) async* {
    if (event is Singup) {
      yield SingupLoading();
      try {
        await pessoaRepository.singup(
            event.email, event.nome, event.cpf, event.senha, event.cliente);
        yield SingupLoaded();
      } catch (e) {
        print(e);
        yield SingupError(e: e);
      }
    } else if (event is GetPessoa) {
      yield SingupLoading();

      // final prefs = await SharedPreferences.getInstance();

      // print('[id_pessoa]: ${prefs.getInt(Constants.idPessoa)}');

      // if (prefs.getInt(Constants.idPessoa) != null) {
      //   var hasInternet = await Helper.checkInternetConnection();

      //   print(hasInternet);

      //       if (await SharedPrefs().checkPessoaLogin()) {
      //         var usuarioLogado;

      //         try {
      //           usuarioLogado = await SharedPrefs().saveUsuarioLogado();
      //           if (usuarioLogado != null)
      //             yield PessoaLoaded(pessoa: usuarioLogado);
      //         } catch (e) {
      //           throw e;
      //         }
      //       } else {
      //         print('####### HERE 1 ########');
      //         SharedPrefs().logoutPessoa();
      //         yield PessoaLoaded(pessoa: null);
      //       }
      //     } else {
      //       print('####### HERE 2 ########');
      //       yield PessoaLoaded(pessoa: null);
      // }
    }
  }
}
