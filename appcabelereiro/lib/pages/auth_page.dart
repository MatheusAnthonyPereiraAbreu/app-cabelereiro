import 'package:appcabelereiro/pages/admin_login_page.dart';
import 'package:flutter/material.dart';
import 'package:appcabelereiro/components/auth_form.dart';
import 'package:appcabelereiro/core/models/auth_form_data.dart';
import 'package:appcabelereiro/core/services/auth_service.dart';
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      if (!mounted) return;
      setState(() => _isLoading = true);
      if (formData.isLogin) {
        await AuthService().login(
          formData.email,
          formData.password,
        );
      } else {
        await AuthService().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (error) {
      // Handle error
    } finally {
      setState(() => _isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: AuthForm(
                  onSubmit: _handleSubmit,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                  20.0), // Adicionando preenchimento de 20 em todos os lados
              child: Align(
                alignment: Alignment
                    .bottomCenter, // Alinhando o botão para o centro inferior
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminLoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Entrar como administrador',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Container(
                decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
