import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:pet_smart/app/data/httpInterceptor.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pet_smart/app/data/models/pessoa_model.dart';
import 'package:pet_smart/app/data/models/usuario_logado_model.dart';
import 'package:pet_smart/app/helpers/exceptions/exceptions.dart';
import 'package:pet_smart/app/helpers/strings.dart';
import 'package:pet_smart/app/helpers/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PessoaProvider {
  final http.Client httpClient;
  final http.Client newHttpClient =
      HttpClientWithInterceptor.build(interceptors: [
    Interceptor(),
  ]);

  PessoaProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<PessoaModel> login(String cpf, String senha) async {
    final Map<String, dynamic> dados = {'cpf': cpf, 'senha': senha};

    final url = '${Constants.baseUrl}/login${Constants.nomedb}';

    final response = await this.httpClient.post(url,
        headers: {HttpHeaders.contentTypeHeader: Constants.applicationJson},
        body: json.encode(dados));

    if (response.statusCode != 200 && response.statusCode != 201) {
      if (response.statusCode == 401) {
        throw UnauthorizedException(
            msg: jsonDecode(response.body)[Constants.error]);
      } else {
        throw InternalServerException(msg: Strings.erroComunicaoServidor);
      }
    }

    final Map<String, dynamic> responseData = jsonDecode(response.body);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.token, responseData[Constants.token]);

    return PessoaModel(
        id: responseData[Constants.pessoa][Constants.id],
        nome: '',
        cpf: responseData[Constants.pessoa][Constants.cpf]);
  }

  /// No aplicativo há dois tipos de usuários
  /// 1. Conta Cliente: Home page onde o usuario pode gerencias seus pets e solicitar servicos.
  /// 2. Conta Fornecedor: São os funcionários/Empresas que forneceram os serviços para a plataforma.
  /// **
  /// 3. Conta Financeiro: Tem permissão da Conta Pessoa + acesso ao sistema
  /// O endpoint /usuarios/:id retornara as respectivas informaçoes do usuario
  ///  dentre elas os campos BOOL cliente e fonrecedor.
  Future<UsuarioLogadoModel> fetchUserConfig(int idPessoa, String token) async {
    final url =
        '${Constants.baseUrl}/usuarios?id_pessoa=$idPessoa${Constants.nomedb}';

    final response = await this.newHttpClient.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      if (response.statusCode == 401) {
        throw UnauthorizedException(
            msg: jsonDecode(response.body)[Constants.error]);
      } else {
        throw InternalServerException(msg: Strings.erroComunicaoServidor);
      }
    }

    // Salva no sharedPrefs essas informaçoes
    try {
      // Dados, Permissão Conta Cliente ou Fornecedor.
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return UsuarioLogadoModel.fromJson(responseData);
    } catch (e) {
      // Lista vazia, Permissão Conta Pessoa.
      return UsuarioLogadoModel();
    }
  }
}
