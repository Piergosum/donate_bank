import 'package:donate_app/app/apiServices.dart';
import 'package:flutter/cupertino.dart';
import '../../models/donate.dart';







class PostsFeedScreenController extends ChangeNotifier{
  
  String? apiMessage;
  String? requestErrorMessage;
  ValueNotifier<bool?> requestPostsLoading = ValueNotifier(null);
  ApiServices apiServices = ApiServices();
  List<Donate> posts = [];
  bool? requestSuccess;

  Future<void> requestPostsPorEstado(String uf, String cidade) async {
    requestPostsLoading.value = true;
    bool apiRequestSuccess = await apiServices.requestPostsPorEstado(uf);
    if (apiRequestSuccess) {
      requestSuccess = true;
      for (Map doacao in apiServices.requestResponse!.data['data']['doacoes'][uf][cidade]) {
        posts.add(Donate.fromJson(doacao));
      }
    } else {
      requestErrorMessage = apiServices.errorMessage;
    }
    requestPostsLoading.value = false;
    
  }

}