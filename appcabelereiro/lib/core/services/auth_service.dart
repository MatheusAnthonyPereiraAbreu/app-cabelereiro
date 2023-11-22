import 'dart:io';

import 'package:appcabelereiro/core/models/app_user.dart';
import 'package:appcabelereiro/core/services/auth_firebase_service.dart';

abstract class AuthService {
  AppUser? get currentUser;

  Stream<AppUser?> get userChanges;

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();

  Future<void> alterarSenha(String novaSenha);

  factory AuthService() {
    return AuthFirebaseService();
  }
}
