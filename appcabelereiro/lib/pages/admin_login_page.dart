import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appcabelereiro/pages/admin_home_page.dart'; // Esta será a próxima tela após o login

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _passwordController = TextEditingController();
  final String adminEmail = 'admin@gmail.com';
  final String adminPassword = 'admin1'; // Senha cadastrada previamente

  Future<void> _handleAdminLogin() async {
    String enteredPassword = _passwordController.text;

    if (enteredPassword == adminPassword) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: adminEmail,
          password: adminPassword,
        );

        if (userCredential.user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminHomePage(),
            ),
          );
        }
      } catch (e) {
        // Trate os erros de login
        print('Erro de login do administrador: $e');
        // Exiba um snackbar ou mensagem de erro ao usuário, se necessário
      }
    } else {
      // Senha incorreta, exibir mensagem para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Senha incorreta. Tente novamente.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Login de Administrador'),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.black,
              Colors.grey.shade900,
              Colors.grey.shade700,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bem-vindo!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Senha do Administrador',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey), // Cor da borda do campo
                            ),
                            labelStyle: TextStyle(
                                color: Colors.grey), // Cor do texto do rótulo
                            hintStyle: TextStyle(
                                color: Colors.grey), // Cor do texto de dica
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _handleAdminLogin,
                          child: Text('Login como Administrador'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}