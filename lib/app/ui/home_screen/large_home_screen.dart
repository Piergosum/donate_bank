import 'package:flutter/material.dart';
import '../../app_colors.dart';
import '../../controllers/home_screen_controller.dart/home_screen_controller.dart';
import '../posts_feed_screen/posts_feed_screen.dart';
import '../posts_feed_screen/small_posts_feed_screen.dart';




class LargeHomeScreen extends StatelessWidget {
  const LargeHomeScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(context) {

    final HomeScreenController homeScreenController = HomeScreenController();

    return Scaffold(
      backgroundColor: AppColors.first,
      body: Column(
        children: [
          Container(
            height: 170,
            width: MediaQuery.of(context).size.width,
            color: AppColors.second,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: SizedBox()
                  ),
                  Expanded(
                    child: Image.asset(
                      'images/logo.png',
                    ),
                  ),
                  const Expanded(
                    child: SizedBox()
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        const Expanded(
                          child: SizedBox()
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            'Pesquisar doação:',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.second,
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: SizedBox()
                        ),
                        Expanded(
                          flex: 5,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 5, right: 5),
                              hintStyle: TextStyle(
                                color: AppColors.third
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.second
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.second
                                ),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: ValueListenableBuilder<String?>(
                                valueListenable: homeScreenController.dropDownValueUf,
                                builder: (context, value, child) {
                                  return DropdownButton<String>(
                                    dropdownColor: AppColors.first,
                                    value: homeScreenController.dropDownValueUf.value,
                                    hint: Center(
                                      child: Text(
                                        'Selecione o estado',
                                        style: TextStyle(
                                          color: AppColors.third,
                                          fontSize: 18
                                        ),
                                      ),
                                    ),
                                    isExpanded: true,
                                    items: homeScreenController.listaEstados.entries.map((e) => 
                                      DropdownMenuItem<String>(
                                        child: Center(
                                          child: Text(
                                            e.key, 
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.second
                                            ),
                                          ),
                                        ), 
                                        value: e.key,
                                      ),
                                    ).toList(), 
                                                  
                                    onChanged: (value) async {
                        
                                      await homeScreenController.changeDropDownValueUf(value!);
                                                        
                                    },
                                    onTap: () {},
                                  );
                                }
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox()
                  ),
                  const VerticalDivider(),
                  const Expanded(
                    flex: 1,
                    child: SizedBox()
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Expanded(
                          //flex: 7,
                          child: SizedBox(
                            height: 50,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'postScreen');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColors.second,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Publicar doação',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.first,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'donatebank@gmail.com',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.second
                            ),
                          )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Divider(height: 1),
          Expanded(
            flex: 7,
            child: Center(
              child: SingleChildScrollView(
                child: ValueListenableBuilder<bool>(
                  valueListenable: homeScreenController.requestLoading, 
                  builder: (context, value, child) {
                    if (value) {
                      return Center(child: CircularProgressIndicator(color: AppColors.second,),);
                    } else {
                      if (homeScreenController.dropDownValueUf.value != null) {
                        if (homeScreenController.requestSuccess == true) {
                          if (homeScreenController.postsPorEstado[homeScreenController.dropDownValueUf.value] != null) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(
                                        builder: (context) => PostsFeedScreen(
                                          uf: homeScreenController.listaEstados[homeScreenController.dropDownValueUf.value].toString(),
                                          cidade: homeScreenController.postsPorEstado[homeScreenController.dropDownValueUf.value].keys.toList()[index].toString()
                                        )
                                      )
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 3,
                                        child: SizedBox()
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Card(
                                          color: AppColors.second,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    homeScreenController.postsPorEstado[homeScreenController.dropDownValueUf.value].keys.toList()[index].toString(),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.first
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    homeScreenController.postsPorEstado[homeScreenController.dropDownValueUf.value][homeScreenController.postsPorEstado[homeScreenController.dropDownValueUf.value].keys.toList()[index]].length.toString(),
                                                    style: TextStyle(
                                                      color: AppColors.first
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 3,
                                        child: SizedBox()
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 30,);
                              },
                              itemCount: homeScreenController.postsPorEstado[homeScreenController.dropDownValueUf.value].keys.toList().length
                            );
                          } else {
                            return const Center(
                            child: Text(
                              'Nenhuma doação no estado selecionado :(',
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                          );
                          }
                        } else {
                          return Center(
                            child: Text(homeScreenController.apiMessage!),
                          );
                        }
                      } else {
                        return const Center(
                          child: SizedBox()
                        );
                      }
                        
                    }
                  }
                ),
              ),
            ),
          )
        ],
      ),
    );
    
  }

}




