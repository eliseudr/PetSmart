import 'package:flutter/material.dart';
import 'package:pet_smart/app/pages/landing_page/landing_page.dart';

class RegistroTela extends StatefulWidget {
  @override
  _RegistroTelaState createState() => _RegistroTelaState();
}

class _RegistroTelaState extends State<RegistroTela> {
  String senha;
  String confirmSenha;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {
    'nome': null,
    'email': null,
    'senha': null,
    'confirmSenha': null
  };
  TextEditingController _displayEmail = TextEditingController();
  TextEditingController _displayNome = TextEditingController();
  TextEditingController _displaySenha = TextEditingController();
  TextEditingController _displayConfirmSenha = TextEditingController();

  _buildBtnVoltar() {
    return Container(
      width: 1000,
      height: 10,
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          //Navegar para tela login
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LandingPage()),
          ); // Navigator
        },
      ),
    );
  }

  _buildTitulo() {
    return Container(
      child: Text(
        'Registre-se PetSmart',
        style: TextStyle(fontSize: 24, color: Colors.black54.withOpacity(0.5)),
      ),
    );
  }

  _buildCampoEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        controller: _displayEmail,
        decoration: new InputDecoration(
          labelText: "E-mail..",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(15.0),
              borderSide: new BorderSide(color: Colors.blueGrey)),
          prefixIcon: Icon(Icons.email_outlined),
        ),
        validator: (val) {
          if (val.length == 0) {
            return "O campo E-mail não pode ser vazio";
          }
          return null;
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(color: Colors.blueGrey),
        onSaved: (String value) {
          formData['email'] = value;
        },
      ),
    );
  }

  _buildCampoNome() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        controller: _displayNome,
        decoration: new InputDecoration(
          labelText: "Usúario..",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(15.0),
              borderSide: new BorderSide(color: Colors.blueGrey)),
          prefixIcon: Icon(Icons.perm_identity),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Nome invalido";
          }
          return null;
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(color: Colors.blueGrey),
        onSaved: (String value) {
          formData['nome'] = value;
        },
      ),
    );
  }

  _buildCampoSenha() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        controller: _displaySenha,
        obscureText: true,
        decoration: new InputDecoration(
          labelText: "Senha..",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(15.0),
              borderSide: new BorderSide(color: Colors.blueGrey)),
          prefixIcon: Icon(Icons.vpn_key_outlined),
        ),
        validator: (val) {
          if (val.length == 0) {
            return "O campo senha não pode ser vazio";
          }
          return null;
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(color: Colors.blueGrey),
        onSaved: (String value) {
          formData['senha'] = value;
        },
      ),
    );
  }

  _buildCampoConfirmarSenha() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        controller: _displayConfirmSenha,
        obscureText: true,
        decoration: new InputDecoration(
          labelText: "Confirme sua senha..",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(15.0),
              borderSide: new BorderSide(color: Colors.blueGrey)),
          prefixIcon: Icon(Icons.vpn_key_outlined),
        ),
        validator: (String val) {
          if (val.length == 0) {
            return "O campo senha não pode ser vazio";
          } else if (confirmSenha != senha) {
            return "Senhas diferentes";
          }
          return null;
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(color: Colors.blueGrey),
        onSaved: (String value) {
          formData['confirmSenha'] = value;
        },
      ),
    );
  }

  _buildBtnFinalizar() {
    return RaisedButton(
      child: Text(
        'Finalizar',
        style: TextStyle(fontSize: 18),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _registrarConta();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            //Botao arrow voltar do IOs
            SizedBox(
              height: 8,
            ),
            _buildBtnVoltar(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Campo Titulo
                  _buildTitulo(),
                  SizedBox(
                    height: 10,
                  ),
                  //Campo digitavel email
                  _buildCampoEmail(),
                  SizedBox(
                    height: 10,
                  ),
                  //Campo digitavel username
                  _buildCampoNome(),
                  SizedBox(
                    height: 10,
                  ),
                  // Campo digitavel password
                  _buildCampoSenha(),
                  SizedBox(
                    height: 10,
                  ),
                  //Campo confirmar a senha
                  _buildCampoConfirmarSenha(),
                  SizedBox(
                    height: 10,
                  ),
                  //Botao finalizar cadastro
                  //Validar senhas ao pressionar o botão
                  _buildBtnFinalizar(),
                  //
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _registrarConta() async {}
}
