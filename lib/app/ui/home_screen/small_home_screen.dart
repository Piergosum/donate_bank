import 'package:flutter/material.dart';
import '../../app_colors.dart';
import '../../controllers/home_screen_controller.dart/home_screen_controller.dart';
import '../posts_feed_screen/posts_feed_screen.dart';





class SmallHomeScreen extends StatelessWidget {
  const SmallHomeScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(context) {

    final HomeScreenController homeScreenController = HomeScreenController();

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 10,),
                  child: Column(
                    children: [
                      Row(
                    children: [
                      Expanded(
                        //flex: 4,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Pesquisar doação:',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.second,
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: SizedBox(),
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
                                              fontSize: 14,
                                              color: AppColors.third
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
                      )
                    ),          
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                
                    ],
                  ),
                ),
                const Divider(height: 1),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
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
                                  fontSize: 14,
                                  color: AppColors.first,
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*child: InkWell(
                          onHover: (value) {
                            homeScreenController.changePublishDonateButtonHoverColor(value);
                          },
                          onTap: () {
                            Navigator.pushNamed(context, 'postScreen');
                          },
                          child: ValueListenableBuilder(
                            valueListenable: homeScreenController.publishDonateButtonHoverColor, 
                            builder: (context, value, child){
                              return Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  color: homeScreenController.publishDonateButtonHoverColor.value ? AppColors.third
                                  : AppColors.second,
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
                              );
                            }
                          ),
                        ),*/
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(height: 1),
                const SizedBox(
                  height: 50,
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: homeScreenController.requestLoading, 
                  builder: (context, value, child) {
                    if (value) {
                      return Center(child: CircularProgressIndicator(color: AppColors.second,),);
                    } else {
                      if (homeScreenController.dropDownValueUf.value != null) {
                        if (homeScreenController.requestSuccess == true) {
                          if (homeScreenController.postsPorEstado[homeScreenController.dropDownValueUf.value] != null) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ListView.separated(
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
                                        Expanded(
                                          flex: 3,
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
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 30,);
                                },
                                itemCount: homeScreenController.postsPorEstado[homeScreenController.dropDownValueUf.value].keys.toList().length
                              ),
                            );
                          } else {
                            return const Center(
                            child: Text(
                              'Nenhuma doação no estado selecionado :(',
                              style: TextStyle(
                                fontSize: 14
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
                )
                  
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.second,
        tooltip: 'Contato',
        child: const Icon(Icons.mail),
        onPressed: () async {
          return showDialog(
                                          context: context, 
                                          builder: (context) {
                                            return AlertDialog(
                                              contentPadding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
                                              content: SizedBox(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const SizedBox(height: 20,),
                                                      const Text(
                                                        'donatebank@gmail.com',
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      const SizedBox(height: 40,),
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          primary: AppColors.second,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        }, 
                                                        child: Row(
                                                          children: const [
                                                            Expanded(
                                                              child: Text(
                                                                'Fechar',
                                                                textAlign: TextAlign.center,
                                                              )
                                                            ),
                                                          ],
                                                        )
                                                      )
                                                    ],
                                                  ),
                                                ),
                                            );
                                          }
                                        );
        }
      ),
    );
    
  }

}




