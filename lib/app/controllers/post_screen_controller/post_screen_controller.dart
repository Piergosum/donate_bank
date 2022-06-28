
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:donate_app/app/apiServices.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';



class PostScreenController extends ChangeNotifier {

  ApiServices apiServices = ApiServices();
  ValueNotifier<String?> dropDownValueEstado = ValueNotifier(null);
  ValueNotifier<String?> dropDownValueCidade = ValueNotifier(null);
  ValueNotifier<String?> emptyField = ValueNotifier(null);
  ValueNotifier<bool> publishDonateButtonHoverColor = ValueNotifier(false);
  //ValueNotifier<bool?> cidadeFieldComplete = ValueNotifier(null);
  //ValueNotifier<bool?> textoFieldComplete = ValueNotifier(null);
  //ValueNotifier<bool?> contatoFieldComplete = ValueNotifier(null);
  List<ValueNotifier<bool?>> imageFieldList = [
    ValueNotifier(null)
  ];
  ValueNotifier<bool> requestButtonLoading = ValueNotifier(false);
  ValueNotifier<bool> requestCidadesLoading = ValueNotifier(false);
  ValueNotifier<List<ValueNotifier<FilePickerResult>>> imageList = ValueNotifier(
    [
      ValueNotifier(const FilePickerResult([]))
    ]
  );
  String? texto;
  String? contato;
  String? requestMessage;

  Map listaEstados = {
    'Acre': 12,
    'Alagoas': 27,
    'Amapá': 16,
    'Amazonas': 13,
    'Bahia': 29,
    'Ceará': 23,
    'Distrito Federal': 53,
    'Espírito Santo': 32,
    'Goiás': 52,
    'Maranhão': 21,
    'Mato Grosso': 51,
    'Mato Grosso do Sul': 50,
    'Minas Gerais': 31,
    'Pará': 15,
    'Paraíba': 25,
    'Paraná': 41,
    'Pernambuco': 26,
    'Piauí': 22,
    'Rio de Janeiro': 33,
    'Rio Grande do Norte': 24,
    'Rio Grande do Sul': 43,
    'Rondônia': 11,
    'Roraima': 14,
    'Santa Catarina': 42,
    'São Paulo': 35,
    'Sergipe': 28,
    'Tocantins': 17
  };

  List<String> listaCidades = [];

  changeDropDownValueEstados(String value) async {
    requestCidadesLoading.value = true;
    dropDownValueEstado.value = value;
    await requestCidadesPorEstado(listaEstados[dropDownValueEstado.value]);
    requestCidadesLoading.value = false;
  }

  changeDropDownValueCidades(String value) async {
    dropDownValueCidade.value = value;
    if (emptyField.value == 'cidade') {
      emptyField.value = '';
    }
    //cidadeFieldComplete.value = true;
  }

  Future<void> requestCidadesPorEstado(int idEstado) async {
    bool result = await apiServices.requestCidadesPorEstado(idEstado);
    if (result) {
      listaCidades.clear();
      dropDownValueCidade.value = null;
      for (var cidade in apiServices.requestResponse!.data) {
        listaCidades.add(cidade['nome']);
      }
    }
  }

  void submitTexto(String textoValue) {
    if (textoValue.isNotEmpty) {
      texto = textoValue;
      if (emptyField.value == 'texto') {
        emptyField.value = '';
      }
    } else {
      texto = null;
    }
  }

  void submitContato(String contatoValue) {
    if (contatoValue.isNotEmpty) {
      contato = contatoValue;
      if (emptyField.value == 'contato') {
        emptyField.value = '';
      }
    } else {
      contato = null;
    }
  }

  addImageField() {
    List<ValueNotifier<FilePickerResult>> fotos = [];
    for (int i = 0; i < imageList.value.length; i++) {
      fotos.add(imageList.value[i]);
    }
    imageList.value.clear();
    fotos.add(ValueNotifier(const FilePickerResult([])));
    imageFieldList.add(ValueNotifier(null));
    imageList.value = fotos;
  }

  deleteImageField() {
    if (imageList.value.length > 1) {
      List<ValueNotifier<FilePickerResult>> fotos = [];
      for (int i = 0; i < imageList.value.length; i++) {
        fotos.add(imageList.value[i]);
      }
      imageList.value.clear();
      fotos.removeLast();
      imageFieldList.removeLast();
      imageList.value = fotos;
    }
  }


  clearPhoto(int index) {
    imageList.value[index].value = const FilePickerResult([]);
    imageFieldList[index].value = null;
  }

  Future<bool> requestGalleryPermission() async {

    if (kIsWeb) {
      return true;
    } else {

      PermissionStatus status = await Permission.storage.status;

      if (status.isGranted == false) {
        status = await Permission.storage.request();
      }
  
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future getPhotoFromGallery(int index) async {
    await requestGalleryPermission();
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(allowMultiple: false, withData: true);
    if (pickedFile != null) {
      imageList.value[index].value = pickedFile;
      imageFieldList[index].value = true;
    }
  }

  bool emptyImageFieldsCheck() {
    List<int> listIndexFotosEmptyField = [];
    for (int i = 0; i < imageFieldList.length; i++) {
      if (imageFieldList[i].value != true) {
        listIndexFotosEmptyField.add(i);
      }
    }
    if (listIndexFotosEmptyField.isNotEmpty) {
      for (int i in listIndexFotosEmptyField) {
        imageFieldList[i].value = false;
      }
      return false;
    } else {
      return true;
    }
  }

  changePublishDonateButtonHoverColor(bool value) async {
    publishDonateButtonHoverColor.value = value;
  }

  bool emptyFieldsCheck() {
    if (dropDownValueCidade.value == null) {
      emptyField.value = 'cidade';
      return false;
    } else if (texto == null) {
      emptyField.value = 'texto';
      return false;
    } else if (contato == null) {
      emptyField.value = 'contato';
      return false;
    } else {
      if(emptyImageFieldsCheck()) {
        return true;
      } else {
        emptyField.value = 'imagem';
        return false;
      }
    }
  }

  /*bool emptyFieldsCheck() {
    List<int> listIndexFotosEmptyField = [];
    for (int i = 0; i < imageFieldList.length; i++) {
      if (imageFieldList[i].value != true) {
        listIndexFotosEmptyField.add(i);
      }
    }
    if (cidadeFieldComplete.value == null) {
      cidadeFieldComplete.value = false;
      return false;
    } else if (textoFieldComplete.value == null) { 
      textoFieldComplete.value = false;
      return false;
    } else if (contatoFieldComplete.value == null) {
      contatoFieldComplete.value = false;
      return false;
    } else if (listIndexFotosEmptyField.isNotEmpty) {
      for (int i in listIndexFotosEmptyField) {
        imageFieldList[i].value = false;
      }
      return false;
    } else {
      return true;
    }

  }*/

  Future<bool> requestUploadPosts() async {
    requestButtonLoading.value = true;
    List<FilePickerResult> fotosListValues = [];
    for (ValueNotifier<FilePickerResult> file in imageList.value) {
      fotosListValues.add(file.value);
    }
    bool allFieldsComplete = emptyFieldsCheck();
    if (allFieldsComplete) {
      bool requestSuccess = await apiServices.requestUploadPosts(dropDownValueEstado.value!, dropDownValueCidade.value!, texto!, contato!, fotosListValues);
      if (requestSuccess) {
        requestButtonLoading.value = false;
        return true;
      } else {
        requestMessage = apiServices.errorMessage;
        requestButtonLoading.value = false;
        return false;
      }
    } else {
      requestButtonLoading.value = false;
      return false;
    }
    
  }

}