import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pet_smart/app/data/bloc/dados_pessoa/dados_pessoa.dart';
import 'package:pet_smart/app/data/bloc/dados_pessoa/dados_pessoa_bloc.dart';
import 'package:pet_smart/app/data/bloc/file/file_bloc.dart';
import 'package:pet_smart/app/data/models/pessoa_model.dart';
import 'package:pet_smart/app/data/models/usuario_logado_model.dart';
import 'package:pet_smart/app/data/providers/arquivo_provider.dart';
import 'package:pet_smart/app/data/providers/pessoa_provider.dart';
import 'package:pet_smart/app/data/repositories/arquivo_repository.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';
import 'package:pet_smart/app/pages/landing_page/landing_page.dart';

class HomeCliente extends StatefulWidget {
  final PessoaRepository pessoaRepository = PessoaRepository(
      pessoaApiClient: PessoaProvider(httpClient: http.Client()));
  final ArquivoRepository arquivoRepository = ArquivoRepository(
      arquivoApiClient: ArquivoProvider(httpClient: http.Client()));
  final UsuarioLogadoModel usuarioLogado;

  HomeCliente({Key key, this.usuarioLogado}) : super(key: key);

  @override
  _HomeClienteState createState() {
    return _HomeClienteState();
  }
}

class _HomeClienteState extends State<HomeCliente>
    with AutomaticKeepAliveClientMixin<HomeCliente> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DadosPessoaBloc _dadosPessoaBloc;
  FileBloc _fileBloc;
  FileBloc _fileBlocSend;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _dadosPessoaBloc =
        DadosPessoaBloc(pessoaRepository: widget.pessoaRepository);
    _dadosPessoaBloc.add(FetchDadosPessoa(
        idPessoa: widget.usuarioLogado.id, token: widget.usuarioLogado.token));
    _fileBloc = FileBloc(arquivoRepository: widget.arquivoRepository);
    _fileBlocSend = FileBloc(arquivoRepository: widget.arquivoRepository);
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  //Text Serviços
  _buildServicos() {
    return Container(
      padding: EdgeInsets.only(top: 12, left: 12),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(
            'Solicitar de Serviços',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ],
      ),
    );
  }

  //LISTA DE SERVIÇOS (COSULTA, BANHO, TOSA.. ETC)
  _buildListServicos() {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Container(
        height: 160,
        child: ListView(
          padding: EdgeInsets.only(
            right: 12,
          ),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    'assets/Imagens/Consulta.jpg',
                    height: 130,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Text(
                    'Consultar',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color: Colors.black54),
                  ),
                ),
              ],
            ),
            //Segunda Imagem
            SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    'assets/Imagens/Banho.jpg',
                    height: 130,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: Text(
                    'Banho',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color: Colors.black54),
                  ),
                ),
              ],
            ),
            //Terceira imagem
            SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    'assets/Imagens/Tosa.jpg',
                    height: 130,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45),
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
            'Meus Animais',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ],
      ),
    );
  }

  //Botao Inserir animais
  _buildBtnInserirAnimais() {
    return Container(
      child: RaisedButton(
        elevation: 10,
        child: Column(
          children: <Widget>[
            Icon(Icons.add, size: 100),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        color: Colors.teal.shade100,
        textColor: Colors.white,
        onPressed: () {
          //todo formInserirAnimal
        },
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
    return BlocBuilder<DadosPessoaBloc, DadosPessoaState>(
      bloc: _dadosPessoaBloc,
      builder: (context, state) {
        if (state is InitialDadosPessoaState) {
          return Container();
        } else if (state is DadosPessoaLoading) {
          return _buildProgressBar();
        } else if (state is DadosPessoaLoaded) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          return RefreshIndicator(
              child: _buildHomeCliente(state.pessoa),
              onRefresh: () {
                // reloadPage();
                return _refreshCompleter.future;
              });
        } else {
          return Text('ERROR !!!!');
        }
      },
    );
  }

  Widget _buildHomeCliente(PessoaModel pessoa) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        title: Text('${pessoa.nome} - CLIENTE',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 16)),
        centerTitle: true,
      ),
      drawer: buildDrawerMenu(context, pessoa),
      body: Container(
        color: Colors.white,
        child: Form(
          //todo if need formKey
          child: Column(
            children: <Widget>[
              // _buildMenu(),
              _buildServicos(),
              SizedBox(height: 12),
              _buildListServicos(),
              SizedBox(height: 12),
              _buildMeusPets(),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildBtnInserirAnimais(),
                    //todo campos meus pets
                  ],
                ),
              )
            ],
          ),
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
