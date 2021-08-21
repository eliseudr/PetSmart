import 'package:pet_smart/app/helpers/utils.dart';

class UsuarioLogadoModel {
  int id;
  bool contaCliente;
  bool contaFornecedor;
  String cpf;
  String token;

  UsuarioLogadoModel({
    this.id,
    this.contaCliente,
    this.contaFornecedor,
    this.cpf,
    this.token,
  });

  static UsuarioLogadoModel fromJson(dynamic json) {
    return UsuarioLogadoModel(
        id: json[Constants.id],
        contaCliente: json[Constants.contaCliente],
        contaFornecedor: json[Constants.contaFornecedor],
        cpf: json[Constants.cpf],
        token: json[Constants.token]);
  }

  static Map<String, dynamic> toJson(UsuarioLogadoModel userLogado) => {
        Constants.id: userLogado.id,
        Constants.contaCliente: userLogado.contaCliente,
        Constants.contaFornecedor: userLogado.contaFornecedor,
        Constants.cpf: userLogado.cpf,
        Constants.token: userLogado.token
      };
}
