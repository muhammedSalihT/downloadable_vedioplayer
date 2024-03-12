import 'package:bot_toast/bot_toast.dart';
import 'package:downloadeble_videoplayer/screens/login/view/login_view.dart';
import 'package:downloadeble_videoplayer/screens/login/viewmodel/login_provider.dart';
import 'package:downloadeble_videoplayer/screens/otp/viewmodel/otp_provider.dart';
import 'package:downloadeble_videoplayer/screens/player/view_model/player_viewmodel.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      ],
      child: ScreenUtilInit(builder: (context, _) {
        return MaterialApp(
          navigatorKey: AppNavigation.navigatorKey,
          debugShowCheckedModeBanner: false,
          builder: BotToastInit(),
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xffF3F3F3),
            primarySwatch: Colors.blue,
          ),
          home: const LoginView(),
        );
      }),
    );
  }
}
