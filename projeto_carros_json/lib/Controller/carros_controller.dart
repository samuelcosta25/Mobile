import 'dart:convert';
import 'dart:io';
import '../Model/carros_model.dart';

class CarrosController {
  List<Carros> _carroList = [];

  List<Carros> get carroList {
    return _carroList;
  }

  // Método para adicionar carros ao arquivo Json
  void addCarro(Carros carros) {
    _carroList.add(carros);
    saveCarrosFile();
  }

  // Salvar no Json (load)
  Future<void> saveCarrosToFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    final file = File('$path/carros.json');
    final jsonList = _carroList.map((carro) => carro.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  // Buscar do Json (upload)
   Future<void> loadCarrosFromFile() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String path = appDocDir.path;
      final file = File('$path/carros.json');
      final jsonList = jsonDecode(await file.readAsString());
      _carroList = jsonList.map<Carro>((json) => Carro.fromJson(json)).toList();
    } catch (e) {
      _carroList = [];
    }
  }

}
