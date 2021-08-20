import 'package:flutter/material.dart';
import 'package:pet_smart/app/pages/login/login_screen.dart';
import 'package:pet_smart/app/pages/registrar/registro_screen.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Widget _buildJaPossuiConta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Já possui uma conta?',
          style: TextStyle(fontSize: 18),
        ),
        FlatButton(
          child: Text(
            'Entrar',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBtnRegistro() {
    return FlatButton(
      child: Text(
        'Registre-se',
        style: TextStyle(fontSize: 18),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
      ),
      padding: const EdgeInsets.all(15),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () {
        //Navegar para tela login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegistroTela()),
        ); // Navigator
      },
    );
  }

  Widget _buildDesc() {
    return Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porttitor mi vitae arcu vestibulum, non gravida ante facilisis.',
      textAlign: TextAlign.left,
    );
  }

  Widget _buildTitulo() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'PetSmart',
        style: TextStyle(
          fontSize: 24,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: AssetImage('assets/Imagens/logo.png'),
            fit: BoxFit.cover,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        //Cor para o background
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Carregando a foto
                  SizedBox(
                    height: 90,
                  ),
                  //Carregar a imagem
                  _buildLogo(),
                  SizedBox(height: 80),
                  //Titulo
                  _buildTitulo(),
                  SizedBox(
                    height: 5,
                  ),
                  //Descriçao
                  _buildDesc(),
                ],
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              _buildBtnRegistro(),
              _buildJaPossuiConta(),
            ]),
          ],
        ),
      ),
    );
  }
}
