import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../app_colors.dart';


class DonatePostCard extends StatelessWidget {
  const DonatePostCard({ Key? key, 
    required this.contato, 
    required this.cidade,
    required this.texto,
    required this.fotosList

  }) : super(key: key);

  final String contato;
  final String cidade;
  final String texto;
  final List fotosList;


  @override
  Widget build(context) {
    return Card(
      color: AppColors.second,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            const SizedBox(height: 20,),
                            Text(
                              texto,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.first,
                              ),
                            ),
                            const SizedBox(height: 20,),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: AppColors.first,
                                  fontSize: 14
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Contato: ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: contato,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )
                            ),
                            const SizedBox(height: 40,),
                            CarouselSlider(
                              items: fotosList.map((e) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.second,
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(e),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height: 500,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                autoPlayCurve: Curves.linear,
                                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ),
                            ),
                            const SizedBox(height: 40,),
                        ],
                      ),
                ),
              ],
            ),               
          ],
        ),
      ),
    );
  }
}




