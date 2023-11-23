import 'package:appcabelereiro/core/services/auth_service.dart';
import 'package:appcabelereiro/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:appcabelereiro/pages/agendamentos_page.dart';
import 'package:appcabelereiro/pages/criar_profissional.dart';

class AdHomePage extends StatelessWidget {
  const AdHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin page',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 50.0,
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      home:  AdminHomePage(),
    );
  }
}

class AdminHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/fundo.jpg',
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    Text(
                      'Você está no modo administrador',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'No canto superior direito você tem acesso ao menu lateral. Lá você possui o controle dos horários marcados pelos clientes, além de poder cadastrar novos profissionais que forem trabalhar com você!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomAppBar(drawerCallback: () {
                  Scaffold.of(context).openDrawer();
                }),
              ),
            ],
          );
        },
      ),
      drawer: CustomDrawer(),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final VoidCallback? drawerCallback;
  
  final AuthService _authService = AuthService();

  CustomAppBar({Key? key, this.drawerCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Seu código personalizado da AppBar
      backgroundColor: Colors.black.withOpacity(0.8),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: drawerCallback,
      ),
      actions: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.grey.shade900,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Sair'),
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (value) async {
              if (value == 'logout') {
                _authService.logout();
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AuthPage()), // Tela de login
              );
              }
            },
          ),
        ),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Criar Profissional'),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CriacaoProfissionalPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Ver Agendamentos'),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AgendamentosPage(),
                ),
              );
            },
          ),
          // Adicione outros ListTile para mais opções do menu, se necessário
        ],
      ),
    );
  }
}
