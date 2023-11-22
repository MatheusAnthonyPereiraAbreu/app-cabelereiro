import 'package:flutter/material.dart';
import 'package:appcabelereiro/core/services/firebase_agendamento.dart'; 
import 'package:appcabelereiro/core/services/auth_service.dart';
import 'package:appcabelereiro/core/models/agendamento_class.dart';


class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final AuthService _authService = AuthService();
  final FirebaseService _firebaseService = FirebaseService();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_authService.currentUser?.imageURL ?? ''),
            ),
            title: Text(_authService.currentUser?.name ?? ''),
            subtitle: Text(_authService.currentUser?.email ?? ''),
          ),
          ListTile(
            title: TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Nova senha'),
            ),
          ),
          ListTile(
            title: Text('Alterar senha'),
            onTap: _alterarSenha,
          ),
          Divider(),
          Text('Meus Agendamentos', style: Theme.of(context).textTheme.headline6),
          FutureBuilder<List<Agendamento>>(
            future: _firebaseService.getAgendamentosDoCliente(_authService.currentUser?.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${snapshot.data![index].cabelereiro} - ${snapshot.data![index].servico}'),
                      subtitle: Text('${snapshot.data![index].data} - ${snapshot.data![index].horario}'),
                      trailing: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          _firebaseService.cancelarAgendamento(snapshot.data![index]);
                        },
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  void _alterarSenha() {
  String novaSenha = _senhaController.text;
  _authService.alterarSenha(novaSenha);
}

}
