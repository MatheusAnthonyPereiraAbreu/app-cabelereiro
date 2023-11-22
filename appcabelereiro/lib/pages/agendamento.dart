import 'package:appcabelereiro/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:appcabelereiro/core/services/firebase_agendamento.dart'; 
import 'package:appcabelereiro/core/models/agendamento_class.dart';
import 'package:appcabelereiro/core/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:appcabelereiro/components/appbar.dart';

class AgendamentoPage extends StatefulWidget {
  final String profissional;
  final String servico;
  AgendamentoPage({Key? key, required this.profissional, required this.servico}) : super(key: key);

  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  String? _horarioSelecionado;
  final AuthService _authService = AuthService(); // Adicione isso
  final FirebaseService _firebaseService = FirebaseService();
  DateTime _selectedDate = DateTime.now();
  List<String> _horarios = ['8:00', '9:00', '10:00', '11:00', '13:00', '14:00', '15:00', '16:00', '17:00'];
  List<String> _horariosOcupados = [];

  @override
  void initState() {
    super.initState();
    _getHorariosOcupados();
  }

  Future<void> _getHorariosOcupados() async {
    String dataFormatada = _selectedDate.toIso8601String().split('T')[0]; // Formata a data aqui
    _horariosOcupados = await _firebaseService.getHorariosOcupados(widget.profissional, dataFormatada);
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('Agendando para: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'), // Formate a data aqui
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: _pickDate,
          ),
          FutureBuilder(
            future: _getHorariosOcupados(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: _horarios.map((horario) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) return Colors.grey;
                              if (_horarioSelecionado == horario) return Colors.green;
                              return Colors.black; // Defina a cor do botão para preto aqui
                            },
                          ),
                        ),
                        onPressed: _horariosOcupados.contains(horario) ? null : () {
                          setState(() {
                            _horarioSelecionado = horario;
                          });
                        },
                        child: Text(horario),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          ElevatedButton(
            onPressed: _horarioSelecionado == null ? null : _agendar,
            style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                  ),
            child: Text('Agendar'),
          ),
        ],
      ),
    );
  }

void _agendar() {
  if (_horarioSelecionado != null) {
    String nomeCliente = _authService.currentUser?.name ?? '';
    String dataFormatada = _selectedDate.toIso8601String().split('T')[0]; // Formata a data aqui
    Agendamento agendamento = Agendamento(
      data: dataFormatada, // Passa a data formatada aqui
      horario: _horarioSelecionado!,
      nomeCliente: nomeCliente,
      servico: widget.servico,
      cabelereiro: widget.profissional,
    );
    _firebaseService.criarAgendamento(agendamento);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('Sucesso', style: TextStyle(color: Colors.green)),
          content: Text('Agendado com sucesso', style: TextStyle(fontSize: 18)),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.blue, fontSize: 18)),
              onPressed: () {
               Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}



 _pickDate() async {
  DateTime? date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 5),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Colors.grey,
          colorScheme: ColorScheme.light(primary: Colors.grey),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary
          ),
        ),
        child: child!,
      );
    },
  );
  if (date != null)
    setState(() {
      _selectedDate = date;
      _getHorariosOcupados();
    });
}
}