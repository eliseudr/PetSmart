// Armazenamento Interno do celular
import 'dart:convert';

import 'package:pet_smart/app/data/models/usuario_logado_model.dart';
import 'package:pet_smart/app/helpers/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
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
    return UsuarioLogadoModel.fromJson(
      json.decode(
          prefsPessoa[Constants.prefs].getString(Constants.usuarioLogado)),
    );
  }
}
