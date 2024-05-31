import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class authService {
  bool isLogged = false;
  final _auth = FirebaseAuth.instance;          
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    {
      try {
        final cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        return cred.user;
      } catch (e) {
        
      }
    }
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    {
      try {
        final cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        return cred.user;
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<String?> getUserId() async {
    try {
      final user = _auth.currentUser;
      final userId = user?.uid;
      return userId;
    } catch (e) {
      rethrow;
    }
  }
  bool logged() {
      final user = _auth.currentUser;
      try {
      if(user == null) {
        return false;
      }
      return true;
      }catch(e) {
          return false;
      }
  }
  void userSignOut() {
    _auth.signOut();
  }
}