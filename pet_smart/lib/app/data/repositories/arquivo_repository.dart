//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'dart:async';
import 'dart:typed_data';
import 'package:meta/meta.dart';
import 'package:pet_smart/app/data/providers/arquivo_provider.dart';

class ArquivoRepository {
  final ArquivoProvider arquivoApiClient;

  ArquivoRepository({@required this.arquivoApiClient})
      : assert(arquivoApiClient != null);

  Future<Uint8List> getFile(
      String nomePasta, String nomeArquivo, String nomeDB, String token) async {
    return await arquivoApiClient.downloadFile(
        nomePasta, nomeArquivo, nomeDB, token);
  }

  Future<String> sendFile(String nomePasta, String nomeArquivo, String base64,
      String nomeDB, String token) async {
    return await arquivoApiClient.uploadFile(
        nomePasta, nomeArquivo, base64, nomeDB, token);
  }
}
