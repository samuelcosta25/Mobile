import 'dart:convert';
import 'dart:io';

import '../Model/produtos_model.dart';

class ProdutoController {
  List<Produto> _produtos = [];
  List<Produto> get produtos {
    return _produtos;
  }

  //Método set
  void setProdutos(List<Produto> produtos) {
    _produtos = produtos;
  }

//Salvar produtos no Json
  Future<void> salvarJson(Produto prod) async {
    final file = File('produtos.json');
    final jsonList = produtos.map((produto) => produto.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

//Carregar produtos do Json
  Future<List<Produto>> carregarJson() async {
    try {
      final file = File('produtos.json');
      final jsonString = await file.readAsString();
      _produtos =
          jsonList.map<Produto>((json) => Produto.fromJson(json)).toList();
    } catch (e) {
      produtos = [];
    }
  }
}
