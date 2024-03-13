import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStoreService {
  static Future<void> saveBearertoken(String isLogin) async {
    const data = FlutterSecureStorage();
    await data.write(key: "isLoggedin", value: isLogin);
    String? storedToken = await data.read(key: "isLoggedin");
    log("isLoggedin $storedToken");
  }

  static getBearertoken() async {
    const data = FlutterSecureStorage();
    String? storedToken = await data.read(key: "isLoggedin");
    log("get isLoggedin  $storedToken");
    return storedToken;
  }

  static Future<void> logOutUser() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "isLoggedin");
  }
}
