import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_smart/app/data/bloc/dados_pessoa/dados_pessoa.dart';
import 'package:pet_smart/app/data/bloc/pet/pet.dart';
import 'package:pet_smart/app/data/bloc/pet/pet_bloc.dart';
import 'package:pet_smart/app/helpers/constants.dart';
import 'package:pet_smart/app/data/providers/pessoa_provider.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';
import 'package:http/http.dart' as http;

class HomeModalPet extends StatefulWidget {
  final PessoaRepository _pessoaRepository = PessoaRepository(
    pessoaApiClient: PessoaProvider(
      httpClient: http.Client(),
    ),
  );
  final int idUsuario;
  final String token;
  final VoidCallback reloadPage;
  HomeModalPet(
      {Key key,
      @required this.idUsuario,
      @required this.token,
      this.reloadPage})
      : super(key: key);

  @override
  _HomeModalPetState createState() => _HomeModalPetState();
}

class _HomeModalPetState extends State<HomeModalPet> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DadosPessoaBloc _dadosPessoaBloc;
  final _nomePet = TextEditingController();
  final _raca = TextEditingController();
  String _dtNascimento = "";
  String _tipoAnimal = "";
  var tipoAnimal;
  int group = 1;
  String _dateTime;
  PetBloc _petBloc;

  @override
  void initState() {
    _dadosPessoaBloc =
        DadosPessoaBloc(pessoaRepository: widget._pessoaRepository);

    _petBloc = PetBloc(
      pessoaRepository: widget._pessoaRepository,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: BlocListener<PetBloc, PetState>(
          bloc: _petBloc,
          listener: (context, state) async {
            if (state is PetLoaded) {
              Navigator.pop(context);
            } else if (state is PetError) {
              print(state.e);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          Constants.adicionarPet,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
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
          ),
        ),
      ),
    );
  }

  _buildNomePet() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: _nomePet,
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
    return Container(
      child: Padding(
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
                  // _tipoAnimal = tipoAnimal;
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
                  _tipoAnimal = tipoAnimal;
                },
              ),
            ),
            Text('Gato'),
          ],
        ),
      ),
    );
  }

  _buildNomeRaca() {
    return TextFormField(
      controller: _raca,
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
                  _dtNascimento = _dateTime;
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
              _submitForm();
              // Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
    _petBloc.add(
      Pet(
          apelido: _nomePet.text,
          nascimento: _dtNascimento,
          raca: _raca.text,
          idUsuario: widget.idUsuario,
          token: widget.token),
    );

    Future.delayed(Duration(milliseconds: 500))
        .then((value) => widget.reloadPage());
  }
}
