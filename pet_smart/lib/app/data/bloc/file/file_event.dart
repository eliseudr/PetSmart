//      Sistema de controle de acesso
//
//      Copyright (C) 2020 Green, Inc

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class FileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchFile extends FileEvent {
  final String nomePasta;
  final String nomeArquivo;
  final String nomeDB;
  final String token;

  FetchFile({
    @required this.nomePasta,
    @required this.nomeArquivo,
    @required this.nomeDB,
    @required this.token,
  });
}

class PostFile extends FileEvent {
  final String nomePasta;
  final String nomeArquivo;
  final String base64;
  final String nomeDB;
  final String token;

  PostFile({
    @required this.nomePasta,
    @required this.nomeArquivo,
    @required this.base64,
    @required this.nomeDB,
    @required this.token,
  });
}
