import 'dart:convert';

import 'package:flutter/services.dart';

import '/Model/ProdutosModel.dart';

// Classe responsável por gerenciar as operações de produtos
class ProdutoController {
  final List<Produto> _produtos = []; // Lista de produtos

  List<Produto> get produtos =>
      _produtos; // Getter para acessar a lista de produtos

  // Método para carregar produtos do arquivo JSON
  Future<void> loadProdutos() async {
    // Carrega o conteúdo do arquivo JSON da pasta assets
    final data = await rootBundle.loadString('assets/produtos.json');
    // Decodifica o conteúdo JSON em uma lista dinâmica
    final jsonList = json.decode(data) as List<dynamic>;
    _produtos.clear();
    // Converte os objetos JSON em instâncias de Produto e adiciona à lista de produtos
    _produtos.addAll(jsonList.map((e) => Produto.fromJson(e)));
  }
}
