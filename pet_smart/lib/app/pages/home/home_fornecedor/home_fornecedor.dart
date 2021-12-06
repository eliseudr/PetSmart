import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pet_smart/app/data/bloc/dados_agendamentos/dados_agendamento.dart';
import 'package:pet_smart/app/data/bloc/dados_pessoa/dados_pessoa.dart';
import 'package:pet_smart/app/data/bloc/dados_pessoa/dados_pessoa_bloc.dart';
import 'package:pet_smart/app/data/bloc/file/file_bloc.dart';
import 'package:pet_smart/app/data/models/pessoa_model.dart';
import 'package:pet_smart/app/data/models/usuario_logado_model.dart';
import 'package:pet_smart/app/data/providers/arquivo_provider.dart';
import 'package:pet_smart/app/data/providers/pessoa_provider.dart';
import 'package:pet_smart/app/data/repositories/arquivo_repository.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';
import 'package:pet_smart/app/pages/home/home_cliente/widgets/btn_addPet.dart';
import 'package:pet_smart/app/pages/landing_page/landing_page.dart';

class HomeFornecedor extends StatefulWidget {
  final PessoaRepository pessoaRepository = PessoaRepository(
      pessoaApiClient: PessoaProvider(httpClient: http.Client()));
  final ArquivoRepository arquivoRepository = ArquivoRepository(
      arquivoApiClient: ArquivoProvider(httpClient: http.Client()));
  final UsuarioLogadoModel usuarioLogado;

  HomeFornecedor({Key key, this.usuarioLogado}) : super(key: key);

  @override
  _HomeFornecedorState createState() {
    return _HomeFornecedorState();
  }
}

class _HomeFornecedorState extends State<HomeFornecedor>
    with AutomaticKeepAliveClientMixin<HomeFornecedor> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DadosPessoaBloc _dadosPessoaBloc;
  DadosAgendamentosBloc _dadosAgendamentosBloc;
  FileBloc _fileBloc;
  FileBloc _fileBlocSend;
  Random random = new Random();
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _dadosPessoaBloc =
        DadosPessoaBloc(pessoaRepository: widget.pessoaRepository);
    _dadosPessoaBloc.add(FetchDadosPessoa(
        idPessoa: widget.usuarioLogado.id, token: widget.usuarioLogado.token));

    // Agendamentos
    _dadosAgendamentosBloc =
        DadosAgendamentosBloc(pessoaRepository: widget.pessoaRepository);
    _dadosAgendamentosBloc.add(FetchDadosAgendamentos(
        idFornecedor: widget.usuarioLogado.id,
        token: widget.usuarioLogado.token));

    _fileBloc = FileBloc(arquivoRepository: widget.arquivoRepository);
    _fileBlocSend = FileBloc(arquivoRepository: widget.arquivoRepository);
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  void reloadPage() {
    // Pets
    _dadosAgendamentosBloc.add(FetchDadosAgendamentos(
        idFornecedor: widget.usuarioLogado.id,
        token: widget.usuarioLogado.token));
  }

  //Text Serviços
  _buildServicos() {
    return Container(
      padding: EdgeInsets.only(top: 12, left: 12),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(
            'Meus Serviços',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ],
      ),
    );
  }

  //LISTA DE SERVIÇOS (COSULTA, BANHO, TOSA.. ETC)
  _buildListServicos() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        height: 160,
        child: ListView(
          padding: EdgeInsets.only(right: 10),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 4),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                          'assets/Imagens/Consulta.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 8),
                  child: Text(
                    'Consultar',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color: Colors.black54),
                  ),
                ),
              ],
            ),
            //Segunda Imagem
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 14, top: 4),
                  child: Container(
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/Imagens/Banho.jpg',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 58, top: 8),
                  child: Text(
                    'Banho',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color: Colors.black54),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 14, top: 4),
                  child: Container(
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/Imagens/Tosa.jpg',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 58, top: 8),
                  child: Text(
                    'Tosa',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Text Meus animais
  _buildMeusPets() {
    return Container(
      padding: EdgeInsets.only(left: 12),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(
            'Agendamentos Pendentes',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ],
      ),
    );
  }

  //Lista de serviços - CRIAR BLOC SERVIÇOS
  _buildBtnInserirAnimais(context) {
    return BlocBuilder<DadosAgendamentosBloc, DadosAgendamentosState>(
        bloc: _dadosAgendamentosBloc,
        builder: (context, state) {
          if (state is InitialDadosAgendamentosState) {
            return Container();
          } else if (state is DadosAgendamentosLoading) {
            return _buildProgressBar();
          } else if (state is DadosAgendamentosLoaded) {
            if (state.agendamentos.length > 0) {
              return Container(
                height: 360,
                child: ListView.builder(
                  padding: EdgeInsets.all(12),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.agendamentos.length,
                  itemBuilder: (context, index) =>
                      _singlePetWidget(state, index),
                ),
              );
            } else {
              return Container(
                height: 500,
              );
              // BtnAdicionarAnimal(widget: widget, reloadPage: reloadPage);
            }
          } else {
            return Text('ERROR !!!!');
          }
        });
  }

  _singlePetWidget(DadosAgendamentosLoaded state, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.only(right: 16),
        height: 400,
        width: 220,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Container(
                height: 200,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/Imagens/pets/dog-${random.nextInt(12) + 1}.png')),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Container(
                height: 20,
                width: 180,
                child: Text(
                    '${state.agendamentos[index].tipoAgendamento}: ${state.agendamentos[index].dtAgendamento}',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Container(
                height: 20,
                width: 180,
                child: Text(
                    '${state.agendamentos[index].nomePet}: ${state.agendamentos[index].raca}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Container(
                height: 30,
                width: 180,
                child: Text(
                    'Responsavel: ${state.agendamentos[index].nomeCliente}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12)),
              ),
            ),
            Container(
              height: 30,
              width: 180,
              child: RaisedButton(
                  color: Colors.teal[200],
                  child: new Text("Consultar mais dados"),
                  onPressed: () => {}),
            ), //abrir detalhes Pet)
          ],
        ),
      ),
    );
  }

  //Popout window para confirmação de 2 etapas
  _createDialogoAlertaSair(BuildContext context) {
    //Botao Cancelar LogOut
    Widget _btnCancelar = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {},
    );
    //Botao confirmar LogOut
    Widget _btnConfirmar = FlatButton(
      child: Text("Confirmar"),
      onPressed: () {
        _signOut().whenComplete(() {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LandingPage()));
        });
      },
    );
    //Configura o AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Deseja sair do aplicativo ?"),
      actions: [
        _btnConfirmar,
        _btnCancelar,
      ],
    );
    //Exibe o AlertDialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        });
  }

  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        _refreshCompleter?.complete();
        _refreshCompleter = Completer();
        reloadPage();
        return;
      },
      child: BlocBuilder<DadosPessoaBloc, DadosPessoaState>(
        bloc: _dadosPessoaBloc,
        builder: (context, state) {
          if (state is InitialDadosPessoaState) {
            return Container();
          } else if (state is DadosPessoaLoading) {
            return _buildProgressBar();
          } else if (state is DadosPessoaLoaded) {
            return _buildHomeFornecedor(state.pessoa);
          } else {
            return Text('ERROR !!!!');
          }
        },
      ),
    );
  }

  Widget _buildHomeFornecedor(PessoaModel pessoa) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.orange,
        ),
        title: Text('${pessoa.nome} - FORNECEDOR',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 16)),
        centerTitle: true,
      ),
      drawer: buildDrawerMenu(context, pessoa),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          //todo if need formKey
          child: Column(
            children: <Widget>[
              // _buildMenu(),
              _buildServicos(),
              SizedBox(height: 12),
              _buildListServicos(),
              SizedBox(height: 12),
              _buildMeusPets(),
              _buildBtnInserirAnimais(context),
            ],
          ),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Drawer buildDrawerMenu(BuildContext context, PessoaModel pessoa) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white12,
            ),
            accountName: new Text(
              '${pessoa.nome}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 16),
            ),
            accountEmail: new Text(
              '${pessoa.email}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 14),
            ),
            currentAccountPicture: new CircleAvatar(
              backgroundImage:
                  NetworkImage('https://source.unsplash.com/random'),
              backgroundColor: Colors.transparent,
            ),
          ),
          //LIST TILE MOSTRAS AS OPÇOES NO APPBAR
          //Campor Perfil
          buildListTileCustomizado(Icons.person, 'Perfil', () => {}),
          //Campo Notificações
          buildListTileCustomizado(
              Icons.notifications, 'Notificações', () => {}),
          //Campo Configurações
          buildListTileCustomizado(Icons.settings, 'Configurações', () {}),
          //Campo Sair
          buildListTileCustomizado(Icons.exit_to_app, 'Sair', () {
            _createDialogoAlertaSair(context);
          }),
        ],
      ),
    );
  }

  Future _signOut() async {
    // await _auth.signOut();
  }

  @override
  void dispose() {
    _dadosPessoaBloc.close();
    _fileBloc.close();
    _fileBlocSend.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

//Customizar Botoes APPBAR
class buildListTileCustomizado extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  buildListTileCustomizado(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
        ),
        child: InkWell(
          //todo metodo onTap
          onTap: onTap,

          splashColor: Colors.teal,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(icon),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(text),
                      ),
                    ]),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
