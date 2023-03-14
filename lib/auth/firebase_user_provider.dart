import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MimirFirebaseUser {
  MimirFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

MimirFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MimirFirebaseUser> mimirFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<MimirFirebaseUser>(
      (user) {
        currentUser = MimirFirebaseUser(user);
        return currentUser!;
      },
    );
