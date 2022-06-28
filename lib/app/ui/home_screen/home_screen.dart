import 'package:donate_app/app/ui/home_screen/small_home_screen.dart';
import 'package:flutter/material.dart';
import 'large_home_screen.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const LargeHomeScreen();
        } else {
          return const SmallHomeScreen();
        }
      },
    );
    
  }

}





