import 'package:donate_app/app/models/donate.dart';
import 'package:donate_app/app/apiServices.dart';
import 'package:flutter/cupertino.dart';
import '../../repo.dart';







class HomeScreenController extends ChangeNotifier {

  Map listaEstados = {
    'Acre': 'AC',
    'Alagoas': 'AL',
    'Amapá': 'AP',
    'Amazonas': 'AM',
    'Bahia': 'BA',
    'Ceará': 'CE',
    'Distrito Federal': 'DF',
    'Espírito Santo': 'ES',
    'Goiás': 'GO',
    'Maranhão': 'MA',
    'Mato Grosso': 'MT',
    'Mato Grosso do Sul': 'MS',
    'Minas Gerais': 'MG',
    'Pará': 'PA',
    'Paraíba': 'PB',
    'Paraná': 'PR',
    'Pernambuco': 'PE',
    'Piauí': 'PI',
    'Rio de Janeiro': 'RJ',
    'Rio Grande do Norte': 'RN',
    'Rio Grande do Sul': 'RS',
    'Rondônia': 'RO',
    'Roraima': 'RR',
    'Santa Catarina': 'SC',
    'São Paulo': 'SP',
    'Sergipe': 'SE',
    'Tocantins': 'TO',
  };

  
  ValueNotifier<bool> requestLoading = ValueNotifier(false);
  String? apiMessage;
  ValueNotifier<String?> dropDownValueUf = ValueNotifier(null);
  ApiServices apiServices = ApiServices();
  Map postsPorEstado = Repo.postsPorEstado;
  List<String> listaCidades = [];
  bool? requestSuccess;
  //ValueNotifier<bool> publishDonateButtonHoverColor = ValueNotifier(false);

  changeDropDownValueUf(String uf) async {
    dropDownValueUf.value = uf;
    await requestPostsPorEstado();

  }

  //changePublishDonateButtonHoverColor(bool value) async {
    //publishDonateButtonHoverColor.value = value;
  //}

  Future<void> requestPostsPorEstado() async {
    requestLoading.value = true;
    bool apiRequestSuccess = await apiServices.requestPostsPorEstado(listaEstados[dropDownValueUf.value]);
    if (apiRequestSuccess) {
      requestSuccess = true;
      if (postsPorEstado[dropDownValueUf.value] != null) {
        postsPorEstado[dropDownValueUf.value].clear();
      }
      postsPorEstado[dropDownValueUf.value] = apiServices.requestResponse!.data['data']['doacoes'][listaEstados[dropDownValueUf.value]];
    } else {
      requestSuccess = false;
      apiMessage = apiServices.errorMessage;
    }
    requestLoading.value = false;
  }
}