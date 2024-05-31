import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media/firebase_auth.dart';

final locator = GetIt.instance;

void setup () {
  bool _isLogged = false;
  locator.registerSingleton<authService>(authService());
}