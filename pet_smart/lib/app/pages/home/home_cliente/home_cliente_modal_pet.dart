import 'package:flutter/material.dart';
import 'package:pet_smart/app/helpers/constants.dart';

class HomeModelPet extends StatefulWidget {
  const HomeModelPet({Key key}) : super(key: key);

  @override
  _HomeModelPetState createState() => _HomeModelPetState();
}

class _HomeModelPetState extends State<HomeModelPet> {
  int group = 1;
  var tipoAnimal;
  String _dateTime;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    Constants.adicionarPet,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  _buildNomePet(),
                  _buildNascimento(),
                  _buildRowRadio(),
                  _buildNomeRaca(),
                  _buildBtnAdicionar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildNomePet() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        decoration: new InputDecoration(
            labelText: "Nome do pet",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: new BorderSide(color: Colors.blueGrey))),
        style: new TextStyle(color: Colors.blueGrey),
      ),
    );
  }

  _buildRowRadio() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 10,
            width: 10,
            margin: EdgeInsets.only(right: 5),
            child: Radio(
              value: 1,
              groupValue: group,
              onChanged: (tipoAnimal) {
                print(tipoAnimal);

                setState(() {
                  group = tipoAnimal;
                });
              },
            ),
          ),
          Text('Cachorro'),
          Container(
            height: 10,
            width: 10,
            margin: EdgeInsets.only(right: 5),
            child: Radio(
              value: 2,
              groupValue: group,
              onChanged: (tipoAnimal) {
                print(tipoAnimal);

                setState(() {
                  group = tipoAnimal;
                });
              },
            ),
          ),
          Text('Gato'),
        ],
      ),
    );
  }

  _buildNomeRaca() {
    return TextFormField(
      decoration: new InputDecoration(
          labelText: "Raça",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(15.0),
              borderSide: new BorderSide(color: Colors.blueGrey))),
      style: new TextStyle(color: Colors.blueGrey),
    );
  }

  _buildNascimento() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              child: _dateTime == null
                  ? Text('Data de nascimento')
                  : Text('$_dateTime'),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2001),
                        lastDate: DateTime.now())
                    .then((date) {
                  setState(() {
                    String convertedDateTime =
                        "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                    _dateTime = convertedDateTime;
                  });
                  print('DATETIME == ' + _dateTime);
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              color: Colors.grey[300],
              textColor: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  _buildBtnAdicionar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: RaisedButton(
            child: Text('Adicionar'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
