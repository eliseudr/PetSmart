import 'package:flutter/material.dart';
import 'package:pet_smart/app/data/bloc/login/login_bloc.dart';
import 'package:pet_smart/app/data/bloc/login/login_event.dart';
import 'package:pet_smart/app/data/bloc/login/login_state.dart';
import 'package:pet_smart/app/data/providers/pessoa_provider.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:pet_smart/app/helpers/utils.dart';

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
    print(_cpfController.text);
    print(_senhaController.text);
    _loginBloc.add(
      Login(
        cpf: _cpfController.text,
        senha: _senhaController.text,
      ),
    );
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
            // _saveUserPrefs(state.pessoa.id, state.pessoa.cpf);
            // } else if (state is PessoaLoaded) {
            //   if (state.pessoa != null) {
            //     Navigator.pushAndRemoveUntil(
            //       context,
            //       MaterialPageRoute<bool>(
            //           builder: (context) => HomePessoa(
            //                 usuarioLogado: state.pessoa,
            //               )),
            //       (Route<dynamic> route) => false,
            //     );
            //   }
            // } else if (state is LoginError) {
            //   _handleErrorResponse(state.e);
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
