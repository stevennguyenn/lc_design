import 'package:firebase_core/firebase_core.dart';

class FirebaseHelper {
  FirebaseHelper._();
  static final instance = FirebaseHelper._();
  Future<void> init() async {
    await Firebase.initializeApp();
  }
}