// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:downloadeble_videoplayer/screens/otp/view/otp_view.dart';
import 'package:downloadeble_videoplayer/screens/player/view/player_view.dart';
import 'package:downloadeble_videoplayer/utils/app_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseMobileAuth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static dynamic verificationID;
  static int forceResendToken = 0;
  static final GlobalKey<ScaffoldState> stateKey = GlobalKey<ScaffoldState>();

  PhoneVerificationCompleted verificationCompleted =
      (PhoneAuthCredential phoneAuthCredential) async {
    log(phoneAuthCredential.smsCode.toString());
    // await auth.signInWithCredential(phoneAuthCredential);

    // Fluttertoast.showToast(
    //     msg:
    //         'Phone number automatically verified and user signed in: ${auth.currentUser?.uid}');
  };

  PhoneVerificationFailed verificationFailed =
      (FirebaseAuthException authException) {
    log('failed');
    ScaffoldMessenger.of(AppNavigation.navigatorKey.currentState!.context)
        .showSnackBar(const SnackBar(
      content: Text(
          'Phone number verification failed.\nPlease check your number and try again'),
    ));
  };

  PhoneCodeSent codeSent = (verificationId, forceResendingToken) {
    log('code send');
    AppNavigation.push(
      context: AppNavigation.navigatorKey.currentState!.context,
      newRoute: AppNavigation.createCustomRoute(
        page: const OtpView(),
      ),
    );
    ScaffoldMessenger.of(AppNavigation.navigatorKey.currentState!.context)
        .showSnackBar(const SnackBar(
      content: Text('Please check your phone for the verification code.'),
    ));
    verificationID = verificationId;
    forceResendToken = forceResendingToken!;
  };

  PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
    // Fluttertoast.showToast(msg: "verification code: $verificationId");
    verificationID = verificationId;
  };

  bool isVerified = false;

  //verify Phone number
  Future<bool> verifyPhoneNumber({String? phoneNumber, context}) async {
    log('Verifying $phoneNumber');
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: "$phoneNumber",
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
          forceResendingToken: forceResendToken);
      isVerified = true;
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Phone Number Verification Failed : $e'),
      ));

      log('$e');
      isVerified = false;
    }

    return isVerified;
  }

  Future<bool> signInWithPhoneNumber(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: otp,
      );

      final User? user = (await auth.signInWithCredential(credential)).user;

      AppNavigation.push(
        context: AppNavigation.navigatorKey.currentState!.context,
        newRoute: AppNavigation.createCustomRoute(
          page: const PlayerView(),
        ),
      );

      ScaffoldMessenger.of(AppNavigation.navigatorKey.currentState!.context)
          .showSnackBar(const SnackBar(
        content: Text('Login succesfully'),
      ));

      return true;
    } catch (e) {
      // Fluttertoast.showToast(msg: "Failed to verify : " + e.toString());
      log('$e');
      ScaffoldMessenger.of(AppNavigation.navigatorKey.currentState!.context)
          .showSnackBar(const SnackBar(
        content:
            Text('Please check and enter the correct verification code again.'),
      ));
      return false;
    }
  }
}
