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
  final String dtAgendamento;
  final int idPet;
  final int idFornecedor;
  final int idUsuario;
  final List<String> tags;

  AgendamentoModel({
    @required this.id,
    @required this.tipoAgendamento,
    @required this.dtAgendamento,
    @required this.idPet,
    @required this.idFornecedor,
    @required this.idUsuario,
    this.tags,
  });

  static AgendamentoModel fromJson(dynamic json) {
    return AgendamentoModel(
      id: json[Constants.id],
      tipoAgendamento: json[Constants.tipoAgendamento],
      dtAgendamento: json[Constants.dtAgendamento],
      idPet: json[Constants.idPet],
      idFornecedor: json[Constants.idFornecedor],
      idUsuario: json[Constants.idUsuario],
      tags: json[Constants.tags] != null ? json[Constants.tags].split(',') : [],
    );
  }
}
