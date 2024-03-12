import 'package:downloadeble_videoplayer/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  String? enterOtp;

  void getEneterOtp({required String value}) {
    enterOtp = value;
    notifyListeners();
  }

  void onVerifyOtp() async {
    if (enterOtp != null) {
      await FirebaseMobileAuth().signInWithPhoneNumber(enterOtp!);
    }
  }
}
