import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qwe/pages/detail1.dart';
import 'package:qwe/pages/home1.dart';
import 'package:qwe/pages/opening.dart';
import 'package:qwe/pages/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //Our fist screen
      home: const WelcomePage(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/opening': (BuildContext context) => const OpeningScreen(),
        '/home': (BuildContext context) => const HomePagee(),
        '/detail': (BuildContext context) => const DetailPagee(),
      },
    );
  }
}
