import 'package:bot_toast/bot_toast.dart';
import 'package:downloadeble_videoplayer/screens/login/view/login_view.dart';
import 'package:downloadeble_videoplayer/screens/player/view_model/player_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
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
          create: (context) => PlayerProvider(),
        ),
      ],
      child: ScreenUtilInit(builder: (context, _) {
        return MaterialApp(
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
