import 'package:flutter/material.dart';
import 'package:pet_smart/home_screen.dart';
import './inicio_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EntrarTela extends StatefulWidget {
  @override
  _EntrarTelaState createState() => _EntrarTelaState();
}

class _EntrarTelaState extends State<EntrarTela> {

  String _email, _senha;

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
      child: Text('PetSmart', style: TextStyle(fontSize: 26,
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
            labelText: "E-mail",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: new BorderSide(
                    color: Colors.blueGrey
                )
            )
        ),
        // ignore: missing_return
        validator: (input){
          if(input.isEmpty){
            return 'Campo vazio';
          }
        },
        onSaved: (input) => _email = input,

        keyboardType: TextInputType.text,
        style: new TextStyle(
            color: Colors.blueGrey
        ),
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
        // ignore: missing_return
        validator: (input){
          if(input.length < 5){
            return 'A senha deve ter mais de 5 caracteres';
          }
        },
        onSaved: (input) => _senha = input,

        keyboardType: TextInputType.text,
        style: new TextStyle(
            color: Colors.blueGrey
          ),
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
        entrar(_email,_senha);
      },
    );
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        key: _formkey,
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
                   _buildTitulo(),
                   SizedBox(height: 20,),
                   _buildCampoEmail(),
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

  Future <void> entrar(String _emaili, String _senha) async {
    // final formState = _formkey.currentState;
    // if(formState.validate()){
    //   formState.save();
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _senha);
        print("Sucesso");
        //Abri janela Home
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeTela())
        );
      }catch(e){
        print(e.message);
      }
   }
}
