import 'package:donate_app/app/ui/home_screen/components/donate_post_card.dart';
import 'package:donate_app/app/ui/posts_feed_screen/small_posts_feed_screen.dart';
import 'package:flutter/material.dart';
import '../../app_colors.dart';
import '../../controllers/posts_feed_screen_controller.dart/posts_feed_screen_controller.dart';
import 'large_posts_feed_screen.dart';





class PostsFeedScreen extends StatelessWidget {
  const PostsFeedScreen({
    Key? key,
    required this.uf,
    required this.cidade
    }) : super(key: key);

    final String uf;
    final String cidade;
    

  
  @override
  Widget build(context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return LargePostsFeedScreen(uf: uf, cidade: cidade,);
        } else {
          return SmallPostsFeedScreen(uf: uf, cidade: cidade,);
        }
      },
    );
    
  }

}



