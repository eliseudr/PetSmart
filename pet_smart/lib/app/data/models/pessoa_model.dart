/*
 *       Sistema de controle de acesso
 *
 *       Copyright (C) 2021 Green, Inc
 */

import 'package:flutter/material.dart';
import 'package:pet_smart/app/helpers/utils.dart';

class PessoaModel {
  final int id;
  final String email;
  final String nome;
  final String cpf;
  final String senha;
  final bool ativo;
  final String criadoEm;
  final bool admin;
  final bool cliente;
  final bool fornecedor;

  PessoaModel({
    @required this.id,
    @required this.nome,
    @required this.cpf,
    this.email,
    this.senha,
    this.ativo,
    this.criadoEm,
    this.admin,
    this.cliente,
    this.fornecedor,
  });

  static PessoaModel fromJson(dynamic json) {
    return PessoaModel(
        id: json[Constants.id],
        nome: json[Constants.nome],
        cpf: json[Constants.cpf],
        email: json[Constants.email],
        senha: json[Constants.senha],
        ativo: json[Constants.ativo],
        criadoEm: json[Constants.criadoEm],
        admin: json[Constants.admin],
        cliente: json[Constants.contaCliente],
        fornecedor: json[Constants.contaFornecedor]);
  }
}
