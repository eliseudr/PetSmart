//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:pet_smart/app/data/bloc/pet/pet.dart';
import 'package:pet_smart/app/data/bloc/pet/pet_state.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final PessoaRepository pessoaRepository;

  PetBloc({@required this.pessoaRepository}) : assert(pessoaRepository != null);

  PetState get initialState => InitialPetState();

  @override
  Stream<PetState> mapEventToState(PetEvent event) async* {
    if (event is Pet) {
      yield PetLoading();
      try {
        await pessoaRepository.addPet(event.apelido, event.nascimento,
            event.raca, event.idUsuario, event.token);
        yield PetLoaded();
      } catch (e) {
        print(e);
        yield PetError(e: e);
      }
    } else if (event is GetPessoa) {
      yield PetLoading();

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
