import 'package:pet_smart/app/data/models/agendamento_model.dart';
import 'package:pet_smart/app/data/models/pessoa_model.dart';
import 'package:pet_smart/app/data/models/pet_model.dart';
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

  Future<PessoaModel> singup(
      String email, String nome, String cpf, String senha, int cliente) async {
    return await pessoaApiClient.singup(email, nome, cpf, senha, 1);
  }

  Future<PessoaModel> addPet(String apelido, String nascimento, String raca,
      int idUsuario, String token) async {
    return await pessoaApiClient.addPet(
        apelido, nascimento, raca, idUsuario, token);
  }

  Future<AgendamentoModel> addAgendamento(
      String tipoAgendamento,
      String dtAgendamento,
      int idPet,
      int idFornecedor,
      int idUsuario,
      String token) async {
    return await pessoaApiClient.addAgendamento(
        tipoAgendamento, dtAgendamento, idPet, idFornecedor, idUsuario, token);
  }

  Future<PessoaModel> getDadosUsuario(int idPessoa, String token) async {
    return await pessoaApiClient.fetchDadosUsuario(idPessoa, token);
  }

  Future<List<PetModel>> getDadosPetUsuario(
      {int idPessoa, String token}) async {
    return await pessoaApiClient.fetchDadosPetUsuario(
        idPessoa: idPessoa, token: token);
  }

  // Verifica se a conta do usuario é Cliente ou Fornecedor
  Future<UsuarioLogadoModel> getUserConfig(int idPessoa, String token) async {
    return await pessoaApiClient.fetchUser(idPessoa, token);
  }
}
