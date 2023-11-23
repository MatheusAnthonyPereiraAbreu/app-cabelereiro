import 'dart:io';
import 'package:flutter/material.dart';
import 'package:appcabelereiro/components/user_image_picker.dart';
import 'package:appcabelereiro/core/models/app_user.dart';
import 'package:appcabelereiro/core/models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não selecionada!');
    }

    final userData = AppUser(
      id: '1',
      name: _formData.name,
      email: _formData.email,
      imageURL: '1',
    );

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Bem-vindo!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_formData.isSignup)
                    UserImagePicker(
                      onImagePick: _handleImagePick,
                    ),
                  if (_formData.isSignup)
                    TextFormField(
                      key: const ValueKey('name'),
                      initialValue: _formData.name,
                      onChanged: (name) => _formData.name = name,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (localName) {
                        final name = localName ?? '';
                        if (name.trim().length < 5) {
                          return 'Nome deve ter no mínimo 5 caracteres.';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('email'),
                    initialValue: _formData.email,
                    onChanged: (email) => _formData.email = email,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    validator: (localEmail) {
                      final email = localEmail ?? '';
                      if (!email.contains('@')) {
                        return 'E-mail informado não é válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    initialValue: _formData.password,
                    onChanged: (password) => _formData.password = password,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Senha'),
                    validator: (localPassword) {
                      final password = localPassword ?? '';
                      if (password.length < 6) {
                        return 'Senha deve ter no mínimo 6 caracteres.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _formData.toggleAuthMode();
                      });
                    },
                    child: Text(
                      _formData.isLogin
                          ? 'Criar uma nova conta?'
                          : 'Já possui conta?',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
