import 'package:flutter/cupertino.dart';

class UnauthorizedException implements Exception {
  final String msg;

  UnauthorizedException({@required this.msg});

  String errorMessage() {
    return msg;
  }

  @override
  String toString() => msg;
}
