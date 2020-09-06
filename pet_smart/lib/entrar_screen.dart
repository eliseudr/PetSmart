import 'package:flutter/material.dart';
import './inicio_screen.dart';

class EntrarTela extends StatefulWidget {
  @override
  _EntrarTelaState createState() => _EntrarTelaState();
}

class _EntrarTelaState extends State<EntrarTela> {

  _buildBtnVoltar(){
    return Container(
      width: 1000,
      alignment: Alignment.topLeft,
      child: IconButton(icon: Icon(Icons.arrow_back_ios),

        onPressed: (){
          //Navegar para tela login
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaInicial()),
          );// Navigator
        },
      ),
    );
  }

  _buildCampoNome(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        decoration: new InputDecoration(
            labelText: "Usúario",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: new BorderSide(
                    color: Colors.blueGrey
                )
            )
        ),
        // validator: (String value){
        //   if(value.isEmpty){
        //     return 'Nome invalido';
        //   }
        // },
        keyboardType: TextInputType.text,
        style: new TextStyle(
            color: Colors.blueGrey
        ),

        // onSaved: (String value){
        //   formData['nome'] = value;
        // },
      ),
    );
  }

  _buildCampoSenha(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        obscureText: true,
        decoration: new InputDecoration(
            labelText: "Senha",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: new BorderSide(
                    color: Colors.blueGrey
                )
            )
        ),
        // validator: (val){
        //   if(val.length == 0){
        //     return "O campo senha não pode ser vazio";
        //   }else{
        //     return null;
        //   }
        // },
        keyboardType: TextInputType.text,
        style: new TextStyle(
            color: Colors.blueGrey
        ),

        // onSaved: (String value){
        //   formData['senha'] = value;
        // },
      ),
    );
  }

  _buildBtnEntrar(){
    return RaisedButton(child: Text('Entrar', style: TextStyle(fontSize: 18),),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,

      onPressed: (){
        //_submitForm();

        //Navegar para tela login
        // Navigator.push(
        // );// Navigator
      },
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

                   _buildCampoNome(),
                   SizedBox(height: 10,),
                   _buildCampoSenha(),
                   SizedBox(height: 20,),
                   _buildBtnEntrar(),
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
