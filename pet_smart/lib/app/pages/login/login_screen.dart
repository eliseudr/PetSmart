import 'package:flutter/material.dart';
import 'package:pet_smart/app/data/bloc/login/login_bloc.dart';
import 'package:pet_smart/app/data/bloc/login/login_event.dart';
import 'package:pet_smart/app/data/bloc/login/login_state.dart';
import 'package:pet_smart/app/data/providers/pessoa_provider.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:pet_smart/app/helpers/shared_prefs.dart';
import 'package:pet_smart/app/helpers/utils.dart';
import 'package:pet_smart/app/pages/home/home_cliente/home_cliente.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final PessoaRepository _pessoaRepository = PessoaRepository(
    pessoaApiClient: PessoaProvider(
      httpClient: http.Client(),
    ),
  );

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  LoginBloc _loginBloc;
  // final _cpfController = MaskedTextController(mask: Constants.cpfMask);
  final _cpfController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void initState() {
    _loginBloc = LoginBloc(
      pessoaRepository: widget._pessoaRepository,
    );

    super.initState();
  }

  _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
    // Salvar usuario no SharedPreferences
    // print(_cpfController.text);
    // print(_senhaController.text);
    _loginBloc.add(
      Login(
        cpf: _cpfController.text,
        senha: _senhaController.text,
      ),
    );
  }

  _saveUserPrefs(int id, String cpf, bool cliente, bool fornecedor) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt(Constants.id, id);
    prefs.setString(Constants.cpf, cpf);
    // Verifica se a conta é cliente ou fornecedor
    if (cliente == true) {
      prefs.setBool(Constants.contaCliente, cliente);
    } else {
      prefs.setBool(Constants.contaFornecedor, fornecedor);
    }

    SharedPrefs sharedPrefs = SharedPrefs();

    final usuarioLogado = await sharedPrefs.saveUsuarioLogado();

    if (cliente == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeCliente(usuarioLogado: usuarioLogado),
        ),
      );
    } else {
      print('CONTA FORNECEDOR: ${fornecedor.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state is LoginLoaded) {
            // print(state.pessoa.id);
            // print(state.pessoa.cpf);
            print('CLIENTE: ${state.pessoa.cliente}');
            print('FORNECEDOR: ${state.pessoa.fornecedor}');
            _saveUserPrefs(state.pessoa.id, state.pessoa.cpf,
                state.pessoa.cliente, state.pessoa.fornecedor);
          } else if (state is PessoaLoaded) {
            if (state.pessoa != null) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<bool>(
                    builder: (context) => HomeCliente(
                          usuarioLogado: state.pessoa,
                        )),
                (Route<dynamic> route) => false,
              );
            }
          } else if (state is LoginError) {
            print(state.e);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: _loginBloc,
          builder: (context, state) {
            if (state is InitialLoginState) {
              return _buildListView();
              // } else if (state is LoginLoading) {
              //   return ProgressBar();
              // } else if (state is PessoaLoaded) {
              //   return _buildListView();
            } else {
              return _buildListView();
            }
          },
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView(
      children: <Widget>[
        // Padding(
        //   padding: EdgeInsets.fromLTRB(32, 16, 16, 32),
        //   child: _buildTabBar(),
        // ),
        Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: _buildTabEntrar()),
      ],
    );
  }

  Widget _buildTabEntrar() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildCampoCpf(),
          _buildCampoSenha(),
          // _buildEsqueciSenhaButton(),
          _buildLoginButton(),
        ],
      ),
    );
  }

  _buildCampoCpf() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        controller: _cpfController,
        decoration: new InputDecoration(
            labelText: "Cpf",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: new BorderSide(color: Colors.blueGrey))),
        validator: (input) {
          if (input.isEmpty) {
            return 'Cpf incorreto';
          }
          return null;
        },
        style: new TextStyle(color: Colors.blueGrey),
      ),
    );
  }

  _buildCampoSenha() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        controller: _senhaController,
        obscureText: true,
        decoration: new InputDecoration(
            labelText: "Senha",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: new BorderSide(color: Colors.blueGrey))),
        validator: (input) {
          if (input.isEmpty) {
            return 'Senha incorreta';
          }
          return null;
        },
        style: new TextStyle(color: Colors.blueGrey),
      ),
    );
  }

  _buildLoginButton() {
    return RaisedButton(
      child: Text(
        'Login',
        style: TextStyle(fontSize: 18),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () {
        _submitForm();
      },
    );
  }
}
