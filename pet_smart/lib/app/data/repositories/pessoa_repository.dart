import 'package:pet_smart/app/data/models/pessoa_model.dart';
import 'package:pet_smart/app/data/models/usuario_logado_model.dart';
import 'package:pet_smart/app/data/providers/pessoa_provider.dart';
import 'package:meta/meta.dart';

class PessoaRepository {
  final PessoaProvider pessoaApiClient;

  PessoaRepository({@required this.pessoaApiClient})
      : assert(pessoaApiClient != null);

  Future<PessoaModel> login(String cpf, String senha) async {
    return await pessoaApiClient.login(cpf, senha);
  }

  // Verifica se a conta do usuario é Cliente ou Fornecedor
  Future<UsuarioLogadoModel> getUserConfig(int idPessoa, String token) async {
    return await pessoaApiClient.fetchUserConfig(idPessoa, token);
  }
}
