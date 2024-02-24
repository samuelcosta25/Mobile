import 'package:somativas1/MenuModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MenusController extends ChangeNotifier {
  // Lista de Menu
  List<Menu> _menus = [];
  // Getter para acessar a lista de Menu
  List<Menu> get menus => _menus;

  // Método para adicionar uma nova tarefa à lista
  void adicionarTarefa(String descricao) {
    if (descricao.trim().isNotEmpty) {
      // Verifica se a descrição já existe na lista
      if (!_menus.any((menu) => menu.descricao.trim() == descricao.trim())) {
        _menus.add(Menu(descricao.trim(), false));
        // Notifica os ouvintes (widgets) sobre a mudança no estado
        notifyListeners();
      }
    }
  }
  // Método para marcar uma tarefa como concluída com base no índice
  void marcarComoConcluida(int indice) {
    if (indice >= 0 && indice < _menus.length) {
      _menus[indice].concluida = true;
      // Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }
  // Método para excluir uma tarefa com base no índice
  void excluirTarefa(int indice) {
    if (indice >= 0 && indice < _menus.length) {
      _menus.removeAt(indice);
      // Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }
}