import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:downloadeble_videoplayer/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController numberCtr = TextEditingController();
  String currentCntryCode = '+91';
  bool isLogin = false;

  void getConuntryCode({required CountryCode value}) {
    currentCntryCode = value.dialCode!;
    notifyListeners();
  }

  void onLogin(context) async {
    try {
      isLogin = true;
      notifyListeners();
      await FirebaseMobileAuth()
          .verifyPhoneNumber(
              phoneNumber: '$currentCntryCode${numberCtr.text}',
              context: context)
          .whenComplete(
            () => isLogin = false,
          );
      notifyListeners();
    } catch (e) {
      isLogin = false;
      notifyListeners();
      log(e.toString());
    }
  }
}
