/*
 *       Sistema de controle de acesso
 *
 *       Copyright (C) 2021 Green, Inc
 */

import 'package:flutter/material.dart';
import 'package:pet_smart/app/helpers/utils.dart';

class PetModel {
  final int id;
  final String apelido;
  final String nascimento;
  final String raca;
  final String idUsuario;

  PetModel({
    @required this.id,
    @required this.apelido,
    @required this.nascimento,
    this.raca,
    @required this.idUsuario,
  });

  static PetModel fromJson(dynamic json) {
    return PetModel(
        id: json[Constants.id],
        apelido: json[Constants.apelido],
        nascimento: json[Constants.nascimento],
        raca: json[Constants.raca],
        idUsuario: json[Constants.idUsuario]);
  }
}
