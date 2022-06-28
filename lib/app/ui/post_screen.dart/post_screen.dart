import 'package:donate_app/app/ui/post_screen.dart/small_post_screen.dart';
import 'package:flutter/material.dart';
import 'large_post_screen.dart';






class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const LargePostScreen();
        } else {
          return const SmallPostScreen();
        }
      },
    );
          
      
    
  }

}











