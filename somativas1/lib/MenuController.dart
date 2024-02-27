import 'package:shared_preferences/shared_preferences.dart';
import 'package:somativas1/MenuModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MenusController extends ChangeNotifier {
  List<Menu> _menus = [];

  List<Menu> get menus => _menus;

  void adicionarTarefa(String descricao) {
    try {
      if (descricao.trim().isNotEmpty) {
        if (!_menus.any((menu) => menu.descricao.trim() == descricao.trim())) {
          Fluttertoast.showToast(
            msg: "Tarefa Adicionada!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          _menus.add(Menu(descricao.trim(), false));
          notifyListeners();
        } else {
          throw Exception("A descrição já existe na lista.");
        }
      } else {
        throw Exception("A descrição não pode estar vazia.");
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erro ao adicionar tarefa: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void marcarComoConcluida(int indice) {
    try {
      if (indice >= 0 && indice < _menus.length) {
        _menus[indice].concluida = true;
        notifyListeners();
      } else {
        throw Exception("Índice inválido para marcar como concluída.");
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erro ao marcar como concluída: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void excluirTarefa(BuildContext context, int indice) {
  try {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão'),
          content: Text('Tem certeza de que deseja excluir esta tarefa?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o AlertDialog
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (indice >= 0 && indice < _menus.length) {
                  _menus.removeAt(indice);
                  notifyListeners();
                  Navigator.of(context).pop(); // Fecha o AlertDialog
                } else {
                  throw Exception("Índice inválido para excluir tarefa.");
                }
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Erro ao excluir tarefa: $e",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}


  void atualizarLista() {
    // Método para atualizar a lista (exemplo: imprime uma mensagem no console)
    // Exemplo: Notifica os ouvintes sobre a mudança no estado
    notifyListeners();

    // Exibe uma mensagem de lista atualizada
    Fluttertoast.showToast(
      msg: "Lista Atualizada!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    // Método para recarregar objetos da lista Menu do armazenamento local
    Future<void> recarregarDadosLocais() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // Recupera os dados armazenados como uma lista de strings
        List<String> tarefasSalvas = prefs.getStringList('tarefas') ?? [];

        // Converte os dados recuperados para a estrutura desejada (Menu no exemplo)
        List<Menu> tarefasRecuperadas = tarefasSalvas.map((descricao) {
          return Menu(descricao, false);
        }).toList();

        // Limpa a lista atual e adiciona os novos itens
        _menus.clear();
        _menus.addAll(tarefasRecuperadas);

        // Notifica os ouvintes sobre a mudança no estado
        notifyListeners();
      } catch (e) {
        print("Erro ao recarregar dados locais: $e");
      }
    }

    // Método para salvar dados no armazenamento local
    Future<void> salvarDadosLocais() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // Converte a lista de tarefas para uma lista de strings
        List<String> tarefasParaSalvar = _menus.map((menu) {
          return menu.descricao;
        }).toList();

        // Salva os dados no armazenamento local
        prefs.setStringList('tarefas', tarefasParaSalvar);
      } catch (e) {
        print("Erro ao salvar dados locais: $e");
      }
    }

    notifyListeners(); //
  }

  void limparTarefas() {
    _menus.clear();
    notifyListeners();
  }
}
