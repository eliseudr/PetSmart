import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_smart/app/data/bloc/agendamento/agendamento.dart';
import 'package:pet_smart/app/helpers/constants.dart';
import 'package:pet_smart/app/data/providers/pessoa_provider.dart';
import 'package:pet_smart/app/data/repositories/pessoa_repository.dart';
import 'package:http/http.dart' as http;

class AgendamentoModalPet extends StatefulWidget {
  final PessoaRepository _pessoaRepository = PessoaRepository(
    pessoaApiClient: PessoaProvider(
      httpClient: http.Client(),
    ),
  );
  final int idUsuario;
  final String token;
  final String tipoAgendamento;
  final VoidCallback reloadPage;
  AgendamentoModalPet(
      {Key key,
      @required this.tipoAgendamento,
      @required this.idUsuario,
      @required this.token,
      this.reloadPage})
      : super(key: key);

  @override
  _ModalAgendamentoState createState() => _ModalAgendamentoState();
}

class _ModalAgendamentoState extends State<AgendamentoModalPet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int idFornecedor;
  int idPet;
  String _dtAgendamento = "";
  String _dateTime;
  String dropdownValue = 'Simba (Leão)';
  var pets = <String>[
    'Simba (Leão)',
    'Chico',
    'Pipoca',
  ];
  var fornecedores = <String>[
    'PetSpace       ',
  ];
  AgendamentoBloc _agendamentoBloc;

  @override
  void initState() {
    _agendamentoBloc = AgendamentoBloc(
      pessoaRepository: widget._pessoaRepository,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BlocListener<AgendamentoBloc, AgendamentoState>(
        bloc: _agendamentoBloc,
        listener: (context, state) async {
          if (state is AgendamentoLoaded) {
            Navigator.pop(context);
          } else if (state is AgendamentoError) {
            print(state.e);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      Constants.selecionarPet,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    _buildSelecionarPet(),
                    Text(
                      Constants.selecionarLoja,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    _buildSelecionarPrestador(),
                    _buildDtAgendamento(),
                    _buildBtnAdicionar(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildSelecionarPet() {
    return DropdownButton<String>(
      // value: dropdownValue,
      value: idPet == null ? null : pets[idPet],
      // elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.grey[300],
      ),
      items: pets.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          idPet = pets.indexOf(value);
          print(idPet);
        });
      },
    );
  }

  _buildSelecionarPrestador() {
    return DropdownButton<String>(
      // value: dropdownValue,
      value: idFornecedor == null ? null : fornecedores[idFornecedor],
      // elevation: 16,

      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.grey[300],
      ),
      items: fornecedores.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          idFornecedor = fornecedores.indexOf(value);
          print(idFornecedor);
        });
      },
    );
  }

  _buildDtAgendamento() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              child: _dateTime == null
                  ? Text('Data da Consulta')
                  : Text('$_dateTime'),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2031))
                    .then((date) {
                  setState(() {
                    String convertedDateTime =
                        "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                    _dateTime = convertedDateTime;
                  });
                  print('DATETIME == ' + _dateTime);
                  _dtAgendamento = _dateTime;
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
            },
          ),
        ),
      ],
    );
  }

  void _submitForm() async {
    if (idPet == 0) {
      // Gambiarra
      idPet = 20;
    }
    if (idPet == 1) {
      // Gambiarra
      idPet = 21;
    }
    if (idFornecedor == 0) {
      // Gambiarra
      idFornecedor = 2;
    }

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
    _agendamentoBloc.add(
      Agendamento(
          tipoAgendamento: widget.tipoAgendamento,
          dtAgendamento: _dtAgendamento,
          idPet: idPet,
          idFornecedor: idFornecedor,
          idUsuario: widget.idUsuario,
          token: widget.token),
    );

    Future.delayed(Duration(milliseconds: 500))
        .then((value) => widget.reloadPage());
  }
}
