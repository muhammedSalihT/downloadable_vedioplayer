import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:downloadeble_videoplayer/screens/login/view/login_view.dart';
import 'package:downloadeble_videoplayer/screens/login/viewmodel/login_provider.dart';
import 'package:downloadeble_videoplayer/screens/otp/viewmodel/otp_provider.dart';
import 'package:downloadeble_videoplayer/screens/player/view/player_view.dart';
import 'package:downloadeble_videoplayer/screens/player/view_model/player_viewmodel.dart';
import 'package:downloadeble_videoplayer/screens/profile/viewmodel/profile_provider.dart';
import 'package:downloadeble_videoplayer/services/secure_store_service.dart';
import 'package:downloadeble_videoplayer/utils/app_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic isUserLoggedIn = false;
  @override
  void initState() {
    isUserLoggedIn = SecureStoreService.getBearertoken();
    log(isUserLoggedIn.toString());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OtpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
      ],
      child: ScreenUtilInit(builder: (context, _) {
        return Consumer<PlayerProvider>(builder: (context, playerPro, _) {
          return MaterialApp(
            darkTheme: ThemeData.dark(),
            themeMode: playerPro.themeMode,
            navigatorKey: AppNavigation.navigatorKey,
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xffF3F3F3),
              primarySwatch: Colors.blue,
            ),
            home: isUserLoggedIn == 'true'
                ? const PlayerView()
                : const LoginView(),
          );
        });
      }),
    );
  }
}
