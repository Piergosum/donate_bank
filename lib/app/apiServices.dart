

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';





class ApiServices {

  String url = 'https://doacaoonline.appspot.com/api/v1/';
  String urlIbge = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados/';
  static bool logged = false;
  static int? authMomentMinute;
  static int? authMomentHour;
  static BaseOptions options = BaseOptions();
  String? errorMessage;
  Dio dio = Dio(options);
  Response? requestResponse;


  Future<bool> requestGet({required String? endPoint, Map<String, dynamic>? queryParameters, bool? apiIbge}) async {
    String? urlChoice;
    if (apiIbge!) {
      urlChoice = urlIbge;
    } else {
      urlChoice = url;
    }
    try {
      Response response = await dio.get(urlChoice + endPoint!, queryParameters: queryParameters!);
      requestResponse = response;
      return true;
    } on DioError catch(e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.sendTimeout || e.type == DioErrorType.other) {
        errorMessage = 'Não foi possível realizar a conexão';
      } else {
        errorMessage = e.response!.data['message'];
      }
      return false;
    }
  }

  Future<bool> requestPost({required String? endPoint, dynamic data}) async {
    try {
      Response response = await dio.post(url + endPoint!, data: data);
      requestResponse = response;
      return true;
    } on DioError catch(e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.sendTimeout || e.type == DioErrorType.other) {
        errorMessage = 'Não foi possível realizar a conexão';
      } else {
        errorMessage = e.response!.data['message'];
      }
      return false;
    }
  }

  Future<bool> requestCidadesPorEstado(int idEstado) async {
    bool result = await requestGet(endPoint: '$idEstado/municipios', queryParameters: {}, apiIbge: true);
    return result;
  }

  Future<bool> requestPostsPorEstado(String uf) async {
    bool result = await requestGet(endPoint: 'doacao/estado', queryParameters: {'estado': uf,}, apiIbge: false);
    return result;
  }

  Future<bool> requestUploadPosts(String estado, String cidade, String texto, String contato, List fotosListValues) async {
    print(fotosListValues);
    List fotosListValuesConverted = [];

    for (FilePickerResult foto in fotosListValues) {
      MultipartFile convertedFoto = MultipartFile.fromBytes(foto.files.first.bytes!, filename: foto.files.first.name, contentType: MediaType('image', 'jpeg'),);
      fotosListValuesConverted.add(convertedFoto);
    }

    FormData formData = FormData.fromMap(
      {
        'texto': texto,
        'contato': contato,
        'estado': estado,
        'cidade': cidade,
        'imagens': fotosListValuesConverted,
      }
    );
    bool result = await requestPost(endPoint: 'doacao', data: formData);
    return result;
  }

  
}