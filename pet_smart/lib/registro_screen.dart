import 'package:flutter/material.dart';
import './inicio_screen.dart';

class RegistroTela extends StatefulWidget {
  @override
  _RegistroTelaState createState() => _RegistroTelaState();
}

class _RegistroTelaState extends State<RegistroTela> {

  String _nome;
  String _email;
  String _senha;
  String _confirmSenha;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  _buildTitulo(){
    return Container(
      child: Text('Registre-se PetSmart', style: TextStyle(fontSize: 24,
          color: Colors.black54.withOpacity(0.5)
        ),
      ),
    );
  }

  _buildCampoEmail(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        decoration: new InputDecoration(
            labelText: "E-mail..",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: new BorderSide(
                    color: Colors.blueGrey
                )
            )
        ),
        validator: (val){
          if(val.length == 0){
            return "O campo nome não pode ser vazio";
          }else{
            return null;
          }
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(
            color: Colors.blueGrey
        ),
      ),
    );
  }

  _buildCampoNome(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        decoration: new InputDecoration(
          labelText: "Usúario..",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(
              color: Colors.blueGrey
            )
          )
        ),
        validator: (String value){
          if(value.isEmpty){
           return 'Nome invalido';
          }
          return null;
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(
          color: Colors.blueGrey
        ),

        onSaved: (String value){
          _nome = value;
        },
      ),
    );
  }

  _buildCampoSenha(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        obscureText: true,
        decoration: new InputDecoration(
            labelText: "Senha..",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: new BorderSide(
                    color: Colors.blueGrey
                )
            )
        ),
        validator: (val){
          if(val.length == 0){
            return "O campo senha não pode ser vazio";
          }else{
            return null;
          }
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(
            color: Colors.blueGrey
        ),
      ),
    );
  }

  _buildCampoConfirmarSenha(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        obscureText: true,
        decoration: new InputDecoration(
            labelText: "Confirme sua senha..",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: new BorderSide(
                    color: Colors.blueGrey
                )
            )
        ),
        validator: (val){
          if(val.length == 0){
            return "O campo senha não pode ser vazio";
          }else{
            return null;
          }
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(
            color: Colors.blueGrey
        ),
      ),
    );
  }

  _buildBtnFinalizar(){
    return RaisedButton(child: Text('Finalizar', style: TextStyle(fontSize: 18),),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: (){
        if(!_formKey.currentState.validate()){
          return;
        }
        _formKey.currentState.save();

        print(_nome);
        
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
          key: _formKey,
          child: Column(
            children: <Widget>[
              //Botao arrow voltar do IOs
              SizedBox(height: 8,),
              _buildBtnVoltar(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Campo Titulo
                    _buildTitulo(),
                    SizedBox(height: 10,),
                    //Campo digitavel email
                    _buildCampoEmail(),
                    SizedBox(height: 10,),
                    //Campo digitavel username
                    _buildCampoNome(),
                    SizedBox(height: 10,),
                    // Campo digitavel password
                    _buildCampoSenha(),
                    SizedBox(height: 10,),
                    //Campo confirmar a senha
                    _buildCampoConfirmarSenha(),
                    SizedBox(height: 10,),
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
      ),
    );
  }
}
