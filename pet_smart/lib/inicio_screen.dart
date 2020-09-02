import 'package:flutter/material.dart';
import 'package:pet_smart/widgets/slide_item.dart';

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
                child: SlideItem(),
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