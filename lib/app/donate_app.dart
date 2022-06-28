import 'package:donate_app/app/rotas.dart';
import 'package:donate_app/app/ui/home_screen/home_screen.dart';
import 'package:donate_app/app/ui/home_screen/small_home_screen.dart';
import 'package:flutter/material.dart';



class DonateApp extends StatelessWidget {
  const DonateApp({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'Donate Bank',
      darkTheme: ThemeData.light(),
        //initialRoute: 'home',
        routes: Rotas.rotas,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen()
        //home: HomeScreenTerceiros(),
    );
  }

}













