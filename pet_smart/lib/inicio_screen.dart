import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        //Cor para o background
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(image: AssetImage('assets/Imagens/logo.png'),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    //Nome do app (PetSmart)
                    SizedBox(height: 50),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('PetSmart', style: TextStyle(fontSize: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porttitor mi vitae arcu vestibulum, non gravida ante facilisis.',
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                FlatButton(child: Text('Iniciando', style: TextStyle(fontSize: 18),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                  padding: const EdgeInsets.all(15),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: (){},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Text('Já possui uma conta?', style: TextStyle(fontSize: 18) ,),
                  FlatButton(child: Text('Entrar', style: TextStyle(fontSize: 18),),),
                ],)
              ],)
            ],
          ),
        ),
      ),
    );
  }
}