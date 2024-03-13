import 'package:downloadeble_videoplayer/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  String? enterOtp;
  bool isOtpLogin = false;

  void getEneterOtp({required String value}) {
    enterOtp = value;
    notifyListeners();
  }

  void onVerifyOtp() async {
    try {
      isOtpLogin = true;
      notifyListeners();
      if (enterOtp != null) {
        await FirebaseMobileAuth()
            .signInWithPhoneNumber(enterOtp!)
            .then((value) => isOtpLogin = false);
        notifyListeners();
      } else {
        isOtpLogin = false;
        notifyListeners();
      }
    } catch (e) {
      isOtpLogin = false;
      notifyListeners();
    }
  }
}
