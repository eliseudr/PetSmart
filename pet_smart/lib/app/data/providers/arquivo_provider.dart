/*
 *       Sistema de controle de acesso
 *
 *       Copyright (C) 2020 Green, Inc
 */

import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:pet_smart/app/helpers/exceptions/exceptions.dart';
import 'package:pet_smart/app/helpers/utils.dart';
import '../httpInterceptor.dart';

class ArquivoProvider {
  final http.Client newHttpClient =
      HttpClientWithInterceptor.build(interceptors: [
    Interceptor(),
  ]);

  final httpClient;

  ArquivoProvider({this.httpClient});

  Future<Uint8List> downloadFile(
      String nomePasta, String nomeArquivo, String nomeDB, String token) async {
    final url =
        '${Constants.baseUrl}/arquivos?nomedb=$nomeDB&pasta=$nomePasta&arquivo=$nomeArquivo';
    final response = await this.newHttpClient.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw InternalServerException(msg: Strings.erroComunicaoServidor);
    }

    Map<String, dynamic> responseData = jsonDecode(response.body);
    return Base64Decoder().convert(responseData['arquivo']);
  }

  Future<String> uploadFile(String nomePasta, String nomeArquivo, String base64,
      String nomeDB, String token) async {
    final Map<String, dynamic> dados = {
      'pasta': nomePasta,
      'arquivo': nomeArquivo,
      'base64': base64,
    };
    final url = '${Constants.baseUrl}/arquivos?nomedb=$nomeDB';
    final response = await this.newHttpClient.post(
      url,
      body: jsonEncode(dados),
      headers: {
        HttpHeaders.contentTypeHeader: Constants.applicationJson,
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    print(url);
    print(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw InternalServerException(msg: Strings.erroComunicaoServidor);
    }

    print(response.body);
    Map<String, dynamic> responseData = jsonDecode(response.body);
    return responseData['mensagem'];
  }
}
