import 'package:firebase_auth/firebase_auth.dart';

class UserOur {
  late String id;

  UserOur.fromFirebase(User user) {
    id = user.uid;
  }
}
