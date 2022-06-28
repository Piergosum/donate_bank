import 'package:donate_app/app/ui/home_screen/components/donate_post_card.dart';
import 'package:flutter/material.dart';
import '../../app_colors.dart';
import '../../controllers/posts_feed_screen_controller.dart/posts_feed_screen_controller.dart';





class SmallPostsFeedScreen extends StatelessWidget {
  const SmallPostsFeedScreen({
    Key? key,
    required this.uf,
    required this.cidade
    }) : super(key: key);

    final String uf;
    final String cidade;
    

  
  @override
  Widget build(context) {

    final PostsFeedScreenController postsFeedScreenController = PostsFeedScreenController();

    return Scaffold(
      backgroundColor: AppColors.first,
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: 100,
              color: AppColors.second,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'images/logo.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 40,),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Doações em ' + cidade,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.second,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40,),
                        const Divider(height: 1),
                        FutureBuilder(
                          future: postsFeedScreenController.requestPostsPorEstado(uf, cidade),
                          builder: (context, snapShot) {
                            return ValueListenableBuilder(
                              valueListenable: postsFeedScreenController.requestPostsLoading, 
                              builder: (context, value, child) {
                                if (postsFeedScreenController.requestPostsLoading.value == true) {
                                  return Center(child: CircularProgressIndicator(color: AppColors.second),);
                                } else {
                                  if (postsFeedScreenController.requestSuccess == true) {
                                    if (postsFeedScreenController.posts.isNotEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 30, bottom: 30),
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return DonatePostCard(
                                              contato: postsFeedScreenController.posts[index].contato, 
                                              cidade: postsFeedScreenController.posts[index].cidade, 
                                              texto: postsFeedScreenController.posts[index].texto,
                                              fotosList: postsFeedScreenController.posts[index].fotosList,
                                    
                                            );
                                          }, 
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(height: 60,);
                                          }, 
                                          itemCount: postsFeedScreenController.posts.length
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text(
                                          'Nenhum doação na cidade selecionada :(',
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        )
                                      );
                                    }
                                  } else {
                                    return Center(
                                      child: Text(
                                        postsFeedScreenController.requestErrorMessage!
                                      )
                                    );
                                  }
                                }
                              }
                            );
                          }
                        )
                        
                      ],
                    ),
                    
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
    
  }

}



