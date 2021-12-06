/*
 *       Sistema de controle de acesso
 *
 *       Copyright (C) 2021 Green, Inc
 */

import 'package:flutter/material.dart';
import 'package:pet_smart/app/helpers/utils.dart';

class AgendamentoModel {
  final int id;
  final String tipoAgendamento;
  final int idPet;
  final String nomePet;
  final String raca;
  final String dtAgendamento;
  final int idUsuario;
  final String nomeCliente;
  final int idFornecedor;
  final String nomeFornecedor;
  final List<String> tags;

  AgendamentoModel({
    @required this.id,
    @required this.tipoAgendamento,
    @required this.idPet,
    @required this.nomePet,
    @required this.raca,
    @required this.dtAgendamento,
    @required this.idUsuario,
    @required this.nomeCliente,
    @required this.idFornecedor,
    @required this.nomeFornecedor,
    this.tags,
  });

  static AgendamentoModel fromJson(dynamic json) {
    return AgendamentoModel(
      id: json[Constants.id],
      tipoAgendamento: json[Constants.tipoAgendamento],
      idPet: json[Constants.idPet],
      nomePet: json[Constants.nomePet],
      raca: json[Constants.raca],
      dtAgendamento: json[Constants.dtAgendamento],
      idUsuario: json[Constants.idUsuario],
      nomeCliente: json[Constants.nomeCliente],
      idFornecedor: json[Constants.idFornecedor],
      nomeFornecedor: json[Constants.nomeFornecedor],
      tags: json[Constants.tags] != null ? json[Constants.tags].split(',') : [],
    );
  }
}
