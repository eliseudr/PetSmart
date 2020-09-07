import 'package:flutter/material.dart';
import 'entrar_screen.dart';

class HomeTela extends StatefulWidget {
  @override
  _HomeTelaState createState() => _HomeTelaState();
}

class _HomeTelaState extends State<HomeTela> {

  //Todo esse botao nao vai existir quando a tela for finalizada, sim apenas um botao SAIR
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

  _buildServicos(){
    return Container(
        padding: EdgeInsets.only(top: 12, left: 12),
        alignment: Alignment.topLeft,
        child: Column(
          children: <Widget>[
            Text('Solicitação de Serviços',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        ),

    );
  }

  //LISTA DE SERVIÇOS (COSULTA, BANHO, TOSA.. ETC)
  _buildListServicos(){
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Container(
        height: 160,
          child: ListView(
            padding: EdgeInsets.only(right: 12,),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset('assets/Imagens/Consulta.jpg', height: 130,),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text('Consultar', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black54),),
                  ),
                ],
              ),
              //Segunda Imagem
              SizedBox(width: 14,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset('assets/Imagens/Banho.jpg', height: 130,),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Text('Banho', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black54),),
                  ),
                ],
              ),
              //Terceira imagem
              SizedBox(width: 14,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset('assets/Imagens/Tosa.jpg', height: 130,),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                      child: Text('Tosa', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black54),),
                  ),
                ],
              ),
            ],
          ),
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
              SizedBox(height: 40,),
              _buildServicos(),
              SizedBox(height: 12,),
              _buildListServicos(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // _buildServicos(),
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
}
