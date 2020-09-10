import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'entrar_screen.dart';

class HomeTela extends StatefulWidget {
  @override
  _HomeTelaState createState() => _HomeTelaState();
}

class _HomeTelaState extends State<HomeTela> {

  //Text Serviços
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
  //Text Meus animais
  _buildMeusPets(){
    return Container(
      padding: EdgeInsets.only(top: 12, left: 12),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text('Meus Animais',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ],
      ),

    );
  }
  //Botao Inserir animais
  _buildBtnInserirAnimais(){
    return Container(
      child: RaisedButton(
        elevation: 10,
        child: Column(
          children: <Widget>[
            Icon(Icons.add, size: 100,),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        color: Colors.teal.shade100,
        textColor: Colors.white,
        onPressed: (){
          //todo formInserirAnimal
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        title: Text('"User"', style: TextStyle(fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 16)
        ),
        centerTitle: true,
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.tealAccent.shade200,

              ),
              accountName: new Text('Eliseu', style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.black87, fontSize: 16),
              ),
              accountEmail: new Text('eliseudr@hotmail.com',style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.black87, fontSize: 14),
              ),
              currentAccountPicture: new CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://scontent.fgyn12-1.fna.fbcdn.net/v/t1.0-9/36969101_1010476269132855_4712000855140728832_o.jpg?_nc_cat=106&_nc_sid=e3f864&_nc_eui2=AeFWUyVbnrOjZ09yHklz2dg2_Aci9BKGL3f8ByL0EoYvd5V2Z6e_GTD1xzCwCsU4FYalzKKCkwecTjZnx05q2e-u&_nc_ohc=bUWnD-b3DzgAX9f1NdR&_nc_ht=scontent.fgyn12-1.fna&oh=fe481a10474eed89504f9e66abec03e1&oe=5F7DEB1A'),
                backgroundColor: Colors.transparent,
              ),
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          //todo if need formKey
          child: Column(
            children: <Widget>[
              // _buildMenu(),
              SizedBox(height: 40,),
              _buildServicos(),
              SizedBox(height: 12,),
              _buildListServicos(),
              SizedBox(height: 12,),
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
}
