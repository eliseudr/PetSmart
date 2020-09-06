import 'package:flutter/material.dart';
import 'entrar_screen.dart';

class HomeTela extends StatefulWidget {
  @override
  _HomeTelaState createState() => _HomeTelaState();
}

class _HomeTelaState extends State<HomeTela> {

  _buildBtnVoltar(){
    return Container(
      width: 1000,
      alignment: Alignment.topLeft,
      child: IconButton(icon: Icon(Icons.arrow_back_ios),

        onPressed: (){
          //Navegar para tela login
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EntrarTela()),
          );// Navigator
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Form(
          //todo if need formKey
          child: Column(
            children: <Widget>[
              //botao voltar IOs
              SizedBox(height: 8,),
              _buildBtnVoltar(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //todo campos
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
