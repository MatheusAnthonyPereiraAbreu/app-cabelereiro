import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:appcabelereiro/core/models/app_user.dart';
import 'package:appcabelereiro/core/services/auth_service.dart';

class AuthFirebaseService implements AuthService {
  static AppUser? _currentUser;

  static final _userStream = Stream<AppUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toAppUser(user);
      controller.add(_currentUser);
    }
  });

  AppUser? get currentUser {
    return _currentUser;
  }

  Stream<AppUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (credential.user == null) return;

    final imageName = '${credential.user!.uid}.jpg';
    final imageURL = await _uploadUserImage(image, imageName);

    await credential.user?.updateDisplayName(name);
    await credential.user?.updatePhotoURL(imageURL);

    await _saveToDoUser(_toAppUser(credential.user!, name, imageURL));
  }

  static AppUser _toAppUser(User user, [String? name, String? imageURL]) {
    return AppUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageURL: imageURL ?? user.photoURL ?? 'chat/assets/images/avatar.png',
    );
  }


  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        final store = FirebaseFirestore.instance;
        final docRef = store.collection('users').doc(credential.user!.uid);

        final userData = await docRef.get();
        final appUser = AppUser(
          id: credential.user!.uid,
          name: userData['name'],
          email: userData['email'],
          imageURL: userData['imageURL'], // Define a imagem do usuário
        );

        // Define a imagem do usuário no objeto AppUser
        _currentUser = appUser;
      }
    } catch (error) {
      // Trate os erros de login
      print("Erro ao fazer login: $error");
    }
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveToDoUser(AppUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageURL': user.imageURL,
    });
  }

  Future<void> alterarSenha(String novaSenha) async {
    User? usuario = FirebaseAuth.instance.currentUser;

    if (usuario != null) {
      await usuario.updatePassword(novaSenha).then((_) {
        print("Senha alterada com sucesso");
      }).catchError((error) {
        print("Falha ao alterar a senha: $error");
      });
    }
  }

  Future<bool> loginAsAdmin(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retorna true se o login for bem-sucedido
      return true;
    } catch (error) {
      // Trate os erros de login
      print("Erro ao fazer login como administrador: $error");
      return false;
    }
  }
}
