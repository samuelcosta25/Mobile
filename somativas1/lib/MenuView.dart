import 'package:provider/provider.dart';
import 'package:somativas1/MenuController.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<MenusController>(context, listen: false).limparTarefas();
                },
                child: Text('Excluir Todas as Tarefas'),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<MenusController>(context, listen: false).atualizarLista();
                },
                child: Text('Atualizar Lista'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nova Tarefa',
                suffixIcon: IconButton(
                  onPressed: () {
                    Provider.of<MenusController>(context, listen: false).adicionarTarefa(_controller.text);
                    _controller.clear();
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<MenusController>(
              builder: (context, model, child) {
                return ListView.builder(
                  itemCount: model.menus.length,
                  itemBuilder: (context, itemIndex) { // Mudança aqui: de index para itemIndex
                    return ListTile(
                      title: Text(model.menus[itemIndex].descricao),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: model.menus[itemIndex].concluida,
                            onChanged: (value) {
                              model.marcarComoConcluida(itemIndex);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              model.excluirTarefa(itemIndex);
                            },
                          ),
                        ],
                      ),
                      onLongPress: () {
                        model.excluirTarefa(itemIndex);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
