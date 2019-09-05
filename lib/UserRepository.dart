import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({
    bool isTrucker,
    String email,
    String password,
    String firstname,
    String lastname,
    String company,
    String dot,
  }) async {
    String name = firstname + " " + lastname;
    return (await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((onValue) {
      String id = onValue.user.uid;
      Firestore.instance.collection('User').document(id).setData({
        'name': name,
        'company': company,
        'isTrucker': isTrucker,
        'dot': dot
      });
    })); //.then create user in firestore
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUserUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<String> getUserName() async {
    String id = await getUserUID();
    DocumentSnapshot userSnapshot =
        await Firestore.instance.collection('User').document(id).get();
    return userSnapshot.data['name'];
  }

  Future<bool> getUserType() async {
    String id = await getUserUID();
    DocumentSnapshot userTypeSnapshot =
        await Firestore.instance.collection('User').document(id).get();
    return userTypeSnapshot.data['isTrucker'];
  }

  Future<String> getUserEmail() async {
    return (await _firebaseAuth.currentUser()).email;
  }
}
