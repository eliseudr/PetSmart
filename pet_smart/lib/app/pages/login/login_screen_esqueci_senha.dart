import 'package:flutter/material.dart';
import 'package:pet_smart/app/helpers/constants.dart';

class LoginModalEsqueciSenha extends StatefulWidget {
  const LoginModalEsqueciSenha({Key key}) : super(key: key);

  @override
  _LoginModalEsqueciSenhaState createState() => _LoginModalEsqueciSenhaState();
}

class _LoginModalEsqueciSenhaState extends State<LoginModalEsqueciSenha> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Constants.redefinirSenha,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                _buildDescricao(),
                _buildEmail(),
                _buildBtnRecuperar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildDescricao() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        // color: Colors.blue,
        child: Padding(
          padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
          child: Text(
            Constants.msgRecuperarSenha,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }

  _buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        decoration: new InputDecoration(
            labelText: "E-mail",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: new BorderSide(color: Colors.blueGrey))),
        style: new TextStyle(color: Colors.blueGrey),
      ),
    );
  }

  _buildBtnRecuperar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: RaisedButton(
            child: Text('Confirmar'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () {
              Navigator.pop(context);
              // TODO: fechar modal e enviar email
            },
          ),
        ),
      ],
    );
  }
}
