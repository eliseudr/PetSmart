import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:pet_smart/app/data/httpInterceptor.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pet_smart/app/data/models/pessoa_model.dart';
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

    final url = '${Constants.baseUrl}/login?nomedb=petsmart';
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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.token, responseData[Constants.token]);

    return PessoaModel(
        id: responseData[Constants.pessoa][Constants.id],
        nome: '',
        cpf: responseData[Constants.pessoa][Constants.cpf]);
  }
}
