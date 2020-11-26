import 'package:flutter/material.dart';
import 'package:pet_smart/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './inicio_screen.dart';

class EntrarTela extends StatefulWidget {
  @override
  _EntrarTelaState createState() => _EntrarTelaState();
}

class _EntrarTelaState extends State<EntrarTela> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        controller: _emailController,
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
        validator: (input){
          if(input.isEmpty){
            return 'E-mail incorreto';
          } return null;
        },
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
        controller: _senhaController,
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
        validator: (input){
          if(input.isEmpty){
            return 'Senha incorreta';
          } return null;
        },
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
      onPressed: () async {
        if(_formKey.currentState.validate()){
          _entraComEmailSenha();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            comEmailSenha(),
          ],
        );
      }),
    );
  }

  Widget comEmailSenha() {
    return Form(
      key: _formKey,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //color: Colors.white,
          child: SizedBox(
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  void _entraComEmailSenha() async {
    try{
      final User user = (await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _senhaController.text)).user;
          if(!user.emailVerified){
            await user.sendEmailVerification();
          }
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
            return HomeTela(user: user,
            );
          }));
    }catch (e){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Falha ao entrar com E-mail e Senha"),
      ));
    }
  }

  void _signOut() async {
    await _auth.signOut();
  }
}
