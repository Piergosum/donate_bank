import 'package:donate_app/app/controllers/post_screen_controller/post_screen_controller.dart';
import 'package:flutter/material.dart';
import '../../app_colors.dart';






class LargePostScreen extends StatelessWidget {
  const LargePostScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(context) {

    final PostScreenController postScreenController = PostScreenController();

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
            flex: 9,
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
                                'Publicar doação',
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
                        Column(
                          children: [
                            const SizedBox(height: 50,),
                            Row(
                              children: [
                                const Expanded(
                                  child: SizedBox()
                                ),
                                Expanded(
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(left: 5, right: 5),
                                      hintStyle: TextStyle(
                                        color: AppColors.third,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:  AppColors.second,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.first,
                                        ),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: ValueListenableBuilder<String?>(
                                        valueListenable: postScreenController.dropDownValueEstado,
                                        builder: (context, value, child) {
                                          return Column(
                                            children: [
                                              DropdownButton<String>(
                                                dropdownColor: AppColors.first,
                                                value: postScreenController.dropDownValueEstado.value,
                                                hint: Text(
                                                  'Selecione o estado',
                                                  style: TextStyle(
                                                    color: AppColors.third,
                                                    fontSize: 18
                                                  
                                                  ),
                                                ),
                                                isExpanded: true,
                                                items: postScreenController.listaEstados.entries.map((e) => 
                                                  DropdownMenuItem<String>(
                                                    child: Center(
                                                      child: Text(
                                                        e.key, 
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:  AppColors.second
                                                        ),
                                                      ),
                                                    ), 
                                                    value: e.key,
                                                  ),
                                                ).toList(), 
                                                              
                                                onChanged: (value) {
                                                  
                                                  postScreenController.changeDropDownValueEstados(value!);
                                                                    
                                                },
                                                onTap: () {},
                                              ),
                                
                                            ],
                                          );
                                        }
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox()
                                ),
                              ],
                            ),
                            const SizedBox(height: 80,),
                            ValueListenableBuilder<bool>(
                              valueListenable: postScreenController.requestCidadesLoading, 
                              builder: (context, value, child) {
                                if (value) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color:  AppColors.second,
                                    ),
                                  );
                                } else {
                                  return Row(
                                    children: [
                                      const Expanded(
                                        child: SizedBox()
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            InputDecorator(
                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.only(left: 5, right: 5),
                                                hintStyle: TextStyle(
                                                  color:  AppColors.second
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:  AppColors.second,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppColors.first,
                                                  ),
                                                ),
                                              ),
                                              child: DropdownButtonHideUnderline(
                                                child: ValueListenableBuilder<String?>(
                                                  valueListenable: postScreenController.dropDownValueCidade,
                                                  builder: (context, value, child) {
                                                    return Column(
                                                      children: [
                                                        DropdownButton<String>(
                                                          dropdownColor: AppColors.first,
                                                          value: postScreenController.dropDownValueCidade.value,
                                                          hint: Text(
                                                            'Selecione a cidade',
                                                            style: TextStyle(
                                                              color: AppColors.third,
                                                              fontSize: 18
                                                            ),
                                                          ),
                                                          isExpanded: true,
                                                          items: postScreenController.listaCidades.map((e) => 
                                                            DropdownMenuItem<String>(
                                                              child: Center(
                                                                child: Text(
                                                                  e, 
                                                                  style: TextStyle(
                                                                    fontSize: 14,
                                                                    color: AppColors.second
                                                                  ),
                                                                ),
                                                              ), 
                                                              value: e,
                                                            ),
                                                          ).toList(), 
                                                                        
                                                          onChanged: (value) {
                                                            
                                                            postScreenController.changeDropDownValueCidades(value!);
                                                                              
                                                          },
                                                          onTap: () {},
                                                        ),
                                
                                                      ],
                                                    );
                                                  }
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            ValueListenableBuilder(
                                              valueListenable: postScreenController.emptyField, 
                                              builder: (context, value, child) {
                                                if (postScreenController.emptyField.value != 'cidade') {
                                                  return const SizedBox();
                                                } else {
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: const [
                                                      Text('Preenchimento obrigatório', style: TextStyle(color: Colors.red),),
                                                    ],
                                                  );
                                                }
                                              }
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Expanded(
                                        child: SizedBox()
                                      ),
                                    ],
                                  );
                                }
                              }
                            ),
                            
                            const SizedBox(height: 80,),
                            Row(
                              children: [
                                const Expanded(
                                  child: SizedBox()
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      TextField(
                                        onChanged: (value) => postScreenController.submitTexto(value),
                                        textInputAction: TextInputAction.next,
                                        maxLines: null,
                                        style: TextStyle(
                                          color: AppColors.second,
                                        ),
                                        autofocus: false,
                                        cursorHeight: 20,
                                        cursorColor: AppColors.second,
                                        decoration: InputDecoration(
                                          isCollapsed: true,
                                          contentPadding: const EdgeInsets.only(left: 5, right: 5, bottom: 100, top: 20),
                                          labelText: 'Texto',
                                          labelStyle: TextStyle(
                                            color:  AppColors.third,
                                            fontSize: 18
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.third,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.second,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      ValueListenableBuilder(
                                        valueListenable: postScreenController.emptyField, 
                                        builder: (context, value, child) {
                                          if (postScreenController.emptyField.value != 'texto') {
                                            return const SizedBox();
                                          } else {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: const [
                                                Text('Preenchimento obrigatório', style: TextStyle(color: Colors.red),),
                                              ],
                                            );
                                          }
                                        }
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox()
                                ),
                              ],
                            ),
                            const SizedBox(height: 80,),
                            Row(
                              children: [
                                const Expanded(
                                  child: SizedBox()
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      TextField(
                                        onChanged: (value) => postScreenController.submitContato(value),
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: AppColors.second
                                        ),
                                        autofocus: false,
                                        cursorHeight: 20,
                                        cursorColor: AppColors.second,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.all(0),
                                          labelText: 'Contato',
                                          labelStyle: TextStyle(
                                            color: AppColors.third,
                                            fontSize: 18
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.third,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.second,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      ValueListenableBuilder(
                                        valueListenable: postScreenController.emptyField, 
                                        builder: (context, value, child) {
                                          if (postScreenController.emptyField.value != 'contato') {
                                            return const SizedBox();
                                          } else {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: const [
                                                Text('Preenchimento obrigatório', style: TextStyle(color: Colors.red),),
                                              ],
                                            );
                                          }
                                        }
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox()
                                ),
                              ],
                            ),
                            const SizedBox(height: 80,),
                            Row(
                              children: [
                                const Expanded(
                                  child: SizedBox()
                                ),
                                Expanded(
                                  child: ValueListenableBuilder<List>(
                                    valueListenable: postScreenController.imageList,
                                    builder: (context, value, child) {
                                      return ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    ValueListenableBuilder(
                                                      valueListenable: postScreenController.imageList.value[index],
                                                      builder: (context, value, child) {
                                                        return TextField(
                                                          readOnly: true,
                                                          style: TextStyle(
                                                            color:AppColors.second
                                                          ),
                                                          autofocus: false,
                                                          cursorHeight: 20,
                                                          cursorColor: AppColors.second,
                                                          decoration: InputDecoration(
                                                            contentPadding: const EdgeInsets.only(left: 5, right: 5),
                                                            hintText: postScreenController.imageList.value[index].value.files.isEmpty ?
                                                            'Nenhuma imagem anexada' :
                                                            postScreenController.imageList.value[index].value.files.first.name,
                                                            hintStyle: TextStyle(
                                                              color: AppColors.third,
                                                              fontSize: 18
                                                            ),
                                                            border: InputBorder.none,
                                                            suffixIcon: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                IconButton(
                                                                  tooltip: 'anexar imagem',
                                                                  icon: Icon(
                                                                    Icons.attach_file,
                                                                    color: AppColors.second
                                                                  ),
                                                                  onPressed: () async {
                                                                    await postScreenController.getPhotoFromGallery(index);
                                                                  },
                                                                ),
                                                                IconButton(
                                                                  tooltip: 'excluir imagem',
                                                                  icon: Icon(
                                                                    Icons.delete,
                                                                    color: AppColors.second,
                                                                  ),
                                                                  onPressed: () async {
                                                                    await postScreenController.clearPhoto(index);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: AppColors.third,
                                                              ),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: AppColors.second,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    ),
                                                    const SizedBox(height: 5,),
                                                    ValueListenableBuilder(
                                                      valueListenable: postScreenController.imageFieldList[index], 
                                                      builder: (context, value, child) {
                                                        if (postScreenController.imageFieldList[index].value == null || postScreenController.imageFieldList[index].value == true) {
                                                          return const SizedBox();
                                                        } else {
                                                          return Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: const [
                                                              Text('Preenchimento obrigatório', style: TextStyle(color: Colors.red),),
                                                            ],
                                                          );
                                                        }
                                                      }
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(height: 30,);
                                        },
                                        itemCount: postScreenController.imageList.value.length
                                      );
                                    }
                                  )
                                ),
                                const Expanded(
                                  child: SizedBox()
                                ),
                              ],
                            ),
                            const SizedBox(height: 50,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  tooltip: 'adicionar campo de imagem',
                                  onPressed: () {
                                    postScreenController.addImageField();
                                  }, 
                                  icon: Icon(
                                    Icons.add,
                                    color: AppColors.second,
                                  )
                                ),
                                const SizedBox(width: 50,),
                                IconButton(
                                  tooltip: 'excluir campo de imagem',
                                  icon: Icon(
                                    Icons.remove,
                                    color: AppColors.second,
                                  ),
                                  onPressed: () async {
                                    await postScreenController.deleteImageField();
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 50,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: SizedBox()
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.second,
                                      ),
                                      onPressed: () async {
                                      bool request = await postScreenController.requestUploadPosts();
                                      if (request == true) {
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
                                                        'Doação enviada com sucesso. Muito obrigado! O mundo é um lugar melhor com você :)',
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
                                        
                                      }, 
                                      child: ValueListenableBuilder(
                                        valueListenable: postScreenController.requestButtonLoading, 
                                        builder: (context, value, child) {
                                          if (postScreenController.requestButtonLoading.value == true) {
                                            return Center(child: CircularProgressIndicator(color: AppColors.first,),);
                                          } else {
                                            return Center(
                                              child: Text(
                                                'Publicar',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: AppColors.first,
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      )
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox()
                                ),
                              ],
                            ),
                            const SizedBox(height: 50,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
          
        ],
      )
    );
          
      
    
  }

}













