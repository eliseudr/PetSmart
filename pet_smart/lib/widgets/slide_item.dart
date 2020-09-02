import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Column(
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
      );
    }
}