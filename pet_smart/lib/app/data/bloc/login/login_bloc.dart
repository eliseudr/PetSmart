//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:pet_smart/app/data/bloc/login/login_event.dart';
import 'package:pet_smart/app/data/bloc/login/login_state.dart';
import 'package:pet_smart/app/data/models/pessoa_model.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';
import 'package:pet_smart/app/helpers/shared_prefs.dart';
import 'package:pet_smart/app/helpers/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PessoaRepository pessoaRepository;

  LoginBloc({@required this.pessoaRepository})
      : assert(pessoaRepository != null);

  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Login) {
      yield LoginLoading();
      try {
        final PessoaModel pessoa =
            await pessoaRepository.login(event.cpf, event.senha);
        yield LoginLoaded(pessoa: pessoa);
      } catch (e) {
        yield LoginError(e: e);
      }
    } else if (event is GetPessoa) {
      yield LoginLoading();

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
