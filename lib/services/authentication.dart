import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    Function()? automaticVerification,
    Function(FirebaseAuthException e)? authenticationFailed,
    Function(String verificationId, int? resendToken)? codeSent,
    int? resendToken,
  });

  Future<String> signIn(String verificationId, String smsCode);

  User? getCurrentUser();

  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    Function()? automaticVerification,
    Function(FirebaseAuthException e)? authenticationFailed,
    Function(String verificationId, int? resendToken)? codeSent,
    int? resendToken,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: resendToken,
      verificationCompleted: (PhoneAuthCredential credential) {
        _firebaseAuth.signInWithCredential(credential);
        // Do automatic verification
        if (automaticVerification != null) automaticVerification();
      },
      verificationFailed: (FirebaseAuthException e) {
        log(e.message!);
        // Do authentication failed
        if (authenticationFailed != null) authenticationFailed(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        // Do code sent
        if (codeSent != null) codeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<String> signIn(String verificationId, String smsCode) async {
    final phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final userCredential =
        await _firebaseAuth.signInWithCredential(phoneAuthCredential);
    return userCredential.user!.uid;
  }

  User? getCurrentUser() {
    var user = _firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
