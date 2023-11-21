import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:haircutapp/core/models/app_user.dart';
import 'package:haircutapp/core/services/auth_service.dart';
import 'package:haircutapp/pages/HomePage.dart';
import 'package:haircutapp/pages/auth_page.dart';
import 'package:haircutapp/pages/loading_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key});

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors
                  .teal, // Cor primária utilizada para AppBar, FloatingActionButton, etc.
              buttonTheme: ButtonThemeData(
                buttonColor: Colors.black, // Cor dos botões
                textTheme:
                    ButtonTextTheme.primary, // Estilo do texto nos botões
              ),
              textTheme: TextTheme(
                bodyText2:
                    TextStyle(color: Colors.black87), // Cor do texto padrão
                headline6:
                    TextStyle(color: Colors.white), // Cor do título da AppBar
              ),
              dividerColor: Colors.black, // Cor das linhas/divisores
            ),
            home: StreamBuilder<AppUser?>(
              stream: AuthService().userChanges,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingPage();
                } else {
                  return snapshot.hasData ? HomePage() : AuthPage();
                }
              },
            ),
          );
        }
      },
    );
  }
}
