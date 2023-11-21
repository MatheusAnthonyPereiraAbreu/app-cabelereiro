import 'package:flutter/material.dart';
import 'package:appcabelereiro/core/services/firebase_agendamento.dart'; 
import 'package:appcabelereiro/core/models/agendamento_class.dart';
class AgendamentoPage extends StatefulWidget {
  final String profissional;
  final String servico;
  AgendamentoPage({Key? key, required this.profissional, required this.servico}) : super(key: key);

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
      Agendamento agendamento = Agendamento(
        data: _selectedDate,
        horario: _horarioSelecionado!,
        nomeCliente: _nomeCliente,
        servico: widget.servico,
        cabelereiro: widget.profissional,
      );
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


