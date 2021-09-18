// Armazenamento Interno do celular
import 'dart:convert';

import 'package:pet_smart/app/data/models/usuario_logado_model.dart';
import 'package:pet_smart/app/data/providers/pessoa_provider.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';
import 'package:pet_smart/app/helpers/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SharedPrefs {
  final PessoaRepository _pessoaRepository = PessoaRepository(
    pessoaApiClient: PessoaProvider(
      httpClient: http.Client(),
    ),
  );
  Future<Map<String, dynamic>> getPessoaPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      Constants.id: prefs.getInt(Constants.id) ?? 0,
      Constants.cpf: prefs.getString(Constants.cpf),
      Constants.token: prefs.getString(Constants.token),
      Constants.prefs: prefs,
    };
  }

  Future<UsuarioLogadoModel> saveUsuarioLogado() async {
    final prefsPessoa = await getPessoaPrefs();

    UsuarioLogadoModel usuarioLogado;

    // Verifica se é conta Cliente ou conta Fornecedor
    try {
      usuarioLogado = await _pessoaRepository.getUserConfig(
        prefsPessoa[Constants.id],
        prefsPessoa[Constants.token],
      );
    } catch (_) {}

    if (usuarioLogado != null) {
      if (usuarioLogado.id == null) {
        usuarioLogado.id = prefsPessoa[Constants.id];
      }
      if (usuarioLogado.contaCliente == null) {
        usuarioLogado.contaCliente = false;
      }
      if (usuarioLogado.contaFornecedor == null) {
        usuarioLogado.contaFornecedor = false;
      }
      if (usuarioLogado.cpf == null) {
        usuarioLogado.cpf = prefsPessoa[Constants.cpf];
      }
      if (usuarioLogado.token == null) {
        usuarioLogado.token = prefsPessoa[Constants.token];
      }
    }

    // print('PrefsPessoa: $prefsPessoa');

    prefsPessoa[Constants.prefs].setString(
      Constants.usuarioLogado,
      json.encode(UsuarioLogadoModel.toJson(usuarioLogado)),
    );

    usuarioLogado = UsuarioLogadoModel.fromJson(json.decode(
      prefsPessoa[Constants.prefs].getString(Constants.usuarioLogado),
    ));

    print('UsuarioLogado: $usuarioLogado');

    return usuarioLogado;
  }
}
