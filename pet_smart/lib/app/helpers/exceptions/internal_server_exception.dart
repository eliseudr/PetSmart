import 'package:flutter/material.dart';

class InternalServerException implements Exception {
  final String msg;

  InternalServerException({@required this.msg});

  String errorMessage() {
    return msg;
  }

  @override
  String toString() => msg;
}
