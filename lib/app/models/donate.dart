class Donate {

  Donate({
    required this.estado,
    required this.contato,
    required this.cidade,
    required this.texto, 
    required this.fotosList

  });

  final String estado;
  final String contato;
  final String cidade;
  final String texto;
  final List fotosList;

  factory Donate.fromJson(Map<dynamic, dynamic> parsedJson) {
    
    return Donate(
      estado: parsedJson['estado'],
      contato: parsedJson['contato'],
      cidade: parsedJson['cidade'],
      texto: parsedJson['texto'] ?? '',
      fotosList: parsedJson['imagens']

    );

  }

  Map<String, dynamic> toJson() {
    return {
      'estado': estado,
      'contato': contato,
      'cidade': cidade,
      'texto': texto,
      'fotosList': fotosList
    };
  }


}