import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:pet_smart/app/data/httpInterceptor.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pet_smart/app/data/models/agendamento_model.dart';
import 'package:pet_smart/app/data/models/pessoa_model.dart';
import 'package:pet_smart/app/data/models/pet_model.dart';
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
      nome: responseData[Constants.pessoa][Constants.nome],
      cpf: responseData[Constants.pessoa][Constants.cpf],
      cliente: responseData[Constants.pessoa][Constants.contaCliente],
      fornecedor: responseData[Constants.pessoa][Constants.contaFornecedor],
    );
  }

  // Chama o Endpoint para registrar um novo usuario
  Future<PessoaModel> singup(
      String email, String nome, String cpf, String senha, int cliente) async {
    final Map<String, dynamic> dados = {
      'email': email,
      'nome': nome,
      'cpf': cpf,
      'senha': senha,
      'cliente': cliente
    };

    final url = '${Constants.baseUrl}/criar_login${Constants.nomedb}';
    print(dados);

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
    return responseData[Constants.mensagem];
  }

  // Post pet
  Future<PessoaModel> addPet(String apelido, String nascimento, String raca,
      int idUsuario, String token) async {
    final Map<String, dynamic> dados = {
      'apelido': apelido,
      'nascimento': nascimento,
      'raca': raca,
      'id_usuario': idUsuario
    };

    final url = '${Constants.baseUrl}/pets${Constants.nomedb}';
    print(dados);

    final response = await this.httpClient.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: Constants.applicationJson,
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
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
    return responseData[Constants.mensagem];
  }

  // TESTAR
  Future<AgendamentoModel> addAgendamento(
      String tipoAgendamento,
      String dtAgendamento,
      int idPet,
      int idFornecedor,
      int idUsuario,
      String token) async {
    final Map<String, dynamic> dados = {
      'tipo_agendamento': tipoAgendamento,
      'data_agendamento': dtAgendamento,
      'id_pet': idPet,
      'id_fornecedor': idFornecedor,
      'id_usuario': idUsuario
    };

    final url = '${Constants.baseUrl}/agendamentos${Constants.nomedb}';
    print(dados);

    final response = await this.httpClient.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: Constants.applicationJson,
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
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
    return responseData[Constants.mensagem];
  }

  /// No aplicativo há dois tipos de usuários
  /// 1. Conta Cliente: Home page onde o usuario pode gerencias seus pets e solicitar servicos.
  /// 2. Conta Fornecedor: São os funcionários/Empresas que forneceram os serviços para a plataforma.
  /// **
  /// 3. Conta Financeiro: Tem permissão da Conta Pessoa + acesso ao sistema
  /// O endpoint /usuarios/:id retornara as respectivas informaçoes do usuario
  ///  dentre elas os campos BOOL cliente e fonrecedor.
  Future<UsuarioLogadoModel> fetchUser(int id, String token) async {
    final url = '${Constants.baseUrl}/usuarios/$id${Constants.nomedb}';

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

  Future<PessoaModel> fetchDadosUsuario(int idPessoa, String token) async {
    final url = '${Constants.baseUrl}/usuarios/$idPessoa${Constants.nomedb}';
    final response = await this.newHttpClient.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw InternalServerException(msg: Strings.erroComunicaoServidor);
    }

    print(response.body);
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return PessoaModel.fromJson(responseData);
  }

  Future<List<PetModel>> fetchDadosPetUsuario(
      {int idPessoa, String token}) async {
    final url =
        '${Constants.baseUrl}/pets${Constants.nomedb}&id_usuario=$idPessoa';
    final response = await this.newHttpClient.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw InternalServerException(msg: Strings.erroComunicaoServidor);
    }

    List<dynamic> responseData = jsonDecode(response.body);

    List<PetModel> fetchDadosPetUsuario = [];

    print(response.body);
    responseData?.forEach((dynamic singlePet) {
      fetchDadosPetUsuario.add(PetModel.fromJson(singlePet));
    });
    return fetchDadosPetUsuario;
  }
}
