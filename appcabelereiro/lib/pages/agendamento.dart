/*import 'package:flutter/material.dart';
import 'package:pomodoro/core/models/user.dart';
import 'package:pomodoro/core/services/auth/auth_firebase_service.dart';
import 'package:intl/intl.dart';

class AgendarHorario extends StatefulWidget {
  final Profissional profissional;

  AgendarHorario({required this.profissional});

  @override
  _AgendarHorarioState createState() => _AgendarHorarioState();
}

class _AgendarHorarioState extends State<AgendarHorario> {
  DateTime dataSelecionada = DateTime.now();
  List<String> horariosIndisponiveis = [];
  final FirebaseService firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar Horário'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Data: ${DateFormat('dd/MM/yyyy').format(dataSelecionada)}'),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              DateTime? data = await showDatePicker(
                context: context,
                initialDate: dataSelecionada,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );

              if (data != null) {
                setState(() {
                  dataSelecionada = data;
                  // Atualize a lista de horários indisponíveis
                  atualizarHorariosIndisponiveis();
                });
              }
            },
          ),
          // Lista de horários vai aqui
        ],
      ),
    );
  }

  void atualizarHorariosIndisponiveis() {
    // Busque os horários indisponíveis do Firebase
    firebaseService.getProfissional(widget.profissional.nome).then((profissional) {
      setState(() {
        horariosIndisponiveis = profissional.datasIndisponiveis.where((dataHorario) => dataHorario.startsWith(DateFormat('yyyy-MM-dd').format(dataSelecionada))).toList();
      });
    });
  }
}
*/

import 'package:flutter/material.dart';
import 'package:appcabelereiro/core/services/firebase.dart'; 

class AgendamentoPage extends StatefulWidget {
  final String profissional;
  AgendamentoPage({Key? key, required this.profissional}) : super(key: key);

  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  String? _horarioSelecionado;
  final FirebaseService _firebaseService = FirebaseService();
  DateTime _selectedDate = DateTime.now();
  List<String> _horarios = ['8:00', '9:00', '10:00', '11:00', '13:00', '14:00', '15:00', '16:00', '17:00'];
  List<String> _horariosOcupados = [];

  @override
  void initState() {
    super.initState();
    _getHorariosOcupados();
  }

  void _getHorariosOcupados() async {
    _horariosOcupados = await _firebaseService.getHorariosOcupados(widget.profissional, _selectedDate);
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamento com ${widget.profissional}'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('Data selecionada: ${_selectedDate.toLocal()}'),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: _pickDate,
          ),
          GridView.count(
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
                        return Theme.of(context).primaryColor;
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
          ),
          ElevatedButton(
            onPressed: _horarioSelecionado == null ? null : _agendar,
            child: Text('Agendar'),
          ),
        ],
      ),
    );
  }

  void _agendar() {
    if (_horarioSelecionado != null) {
      _firebaseService.agendarHorario(widget.profissional, _selectedDate, _horarioSelecionado!);
    }
  }


  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (date != null)
      setState(() {
        _selectedDate = date;
        _getHorariosOcupados();
      });
  }
}


