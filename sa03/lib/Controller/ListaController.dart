
import 'package:flutter/material.dart';
import '/Model/ListaModel.dart';

class ListaController extends ChangeNotifier {
  // Lista de Tarefas
  List<Lista> _listas = [];

  // Getter para acessar a lista de tarefas
  List<Lista> get listas => _listas;

  // Método para adicionar uma nova tarefa à lista
  void adicionarTarefa(String descricao, BuildContext context) {
    if (descricao.trim().isNotEmpty) {
      // Verifica se a tarefa já existe na lista (comparação case-insensitive)
      if (_listas.any((tarefa) => tarefa.descricao.toLowerCase() == descricao.trim().toLowerCase())) {
        // Tarefa duplicada, exibe a mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Este item já está na lista.'),
          ),
        );
      } else {
        // Adiciona a nova tarefa à lista
        _listas.add(Lista(descricao.trim(), false));
        // Ordena a lista em ordem alfabética
        _listas.sort((a, b) => a.descricao.compareTo(b.descricao));
        // Notifica os ouvintes sobre a mudança no estado
        notifyListeners();
        // Mensagem de confirmação ao adicionar a tarefa
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Item adicionado com sucesso!'),
          ),
        );
      }
    } else {
      // Campo vazio, exibe a mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não é possível adicionar um item vazio.'),
        ),
      );
    }
  }

  // Método para marcar uma tarefa como concluída com base no índice
  void marcarComoConcluida(int indice) {
    if (indice >= 0 && indice < _listas.length) {
      // Altera o estado de conclusão da tarefa
      _listas[indice].concluida = !_listas[indice].concluida;
      // Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

  // Método para excluir uma tarefa com base no índice
  void excluirTarefa(int indice, BuildContext context) {
    if (indice >= 0 && indice < _listas.length) {
      // Exibe a caixa de confirmação ao excluir a tarefa
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmação'),
            content: Text('Deseja realmente excluir o item "${_listas[indice].descricao}"?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  // Remove o item da lista
                  _listas.removeAt(indice);
                  // Notifica os ouvintes sobre a mudança no estado
                  notifyListeners();
                  // Fecha a caixa de confirmação
                  Navigator.of(context).pop();
                  // Mensagem de confirmação ao excluir a tarefa
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Item removido com sucesso!'),
                    ),
                  );
                },
                child: Text('Confirmar'),
              ),
            ],
          );
        },
      );
    } else {
      // Índice inválido, exibe a mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Índice de item inválido.'),
        ),
      );
    }
  }
}
