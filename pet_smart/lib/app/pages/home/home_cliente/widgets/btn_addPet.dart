import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pet_smart/app/pages/home/home_cliente/home_cliente_modal_pet.dart';

import '../home_cliente.dart';

class BtnAdicionarAnimal extends StatelessWidget {
  final VoidCallback reloadPage;
  const BtnAdicionarAnimal({Key key, @required this.widget, this.reloadPage})
      : super(key: key);

  final HomeCliente widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 68),
      child: Container(
        child: RaisedButton(
          elevation: 10,
          child: Icon(Icons.add, size: 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          color: Colors.teal.shade100,
          textColor: Colors.white,
          onPressed: () {
            return showBarModalBottomSheet(
                context: context,
                builder: (context) => HomeModalPet(
                    idUsuario: widget.usuarioLogado.id,
                    token: widget.usuarioLogado.token,
                    reloadPage: reloadPage));
          },
        ),
      ),
    );
  }
}
