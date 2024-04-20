import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/View/ViewConfiguracoes.dart'; // Importe o arquivo ViewConfiguracoes.dart

class PaginaLista extends StatelessWidget {
  String user;
  PaginaLista({required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: TaskListScreen(user: user),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  String user;
  TaskListScreen({required this.user});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late SharedPreferences _prefs;
  List<Task> _tasks = [];
  TextEditingController _taskController = TextEditingController();
  bool _showCompleted = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddDialog,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadTasks,
          ),
          IconButton(
            icon: Icon(Icons.settings), // Ícone para a tela de configurações
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfiguracoesPage(email: '',)), // Navega para a tela de configurações
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Text(
                      'Mostrar Tarefas Completadas',
                      style: TextStyle(fontSize: 16),
                    ),
                    contentPadding: EdgeInsets.all(0),
                    value: _showCompleted,
                    onChanged: (value) {
                      setState(() {
                        _showCompleted = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                if (!_showCompleted && task.completed) {
                  return SizedBox.shrink();
                }
                return ListTile(
                  title: Text(
                    task.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editTask(task, index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteTask(index);
                        },
                      ),
                      Checkbox(
                        value: task.completed,
                        onChanged: (value) {
                          setState(() {
                            task.completed = value!;
                            _saveTasks();
                            _showFeedbackMessage('Tarefa marcada como ' +
                                (value ? 'completada' : 'incompleta'));
                          });
                        },
                      ),
                    ],
                  ),
                  onLongPress: () {
                    setState(() {
                      _tasks.removeAt(index);
                      _saveTasks();
                      _showFeedbackMessage('Tarefa removida');
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFeedbackMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _showAddDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        String newTask = '';
        return AlertDialog(
          title: Text('Adicionar Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newTask = value;
                },
                controller: _taskController,
                decoration: InputDecoration(
                  hintText: 'Digite a nova tarefa',
                ),
              ),
              if (_taskController.text.isEmpty)
                Text(
                  'Insira sua tarefa',
                  style: TextStyle(color: Color.fromARGB(255, 4, 171, 177)),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (newTask.isNotEmpty) {
                    _tasks.add(Task(description: newTask));
                    _taskController.clear();
                    _saveTasks();
                    _showFeedbackMessage('Tarefa adicionada com sucesso!');
                    Navigator.pop(context);
                  }
                });
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editTask(Task task, int index) async {
    showDialog(
      context: context,
      builder: (context) {
        String editedTask = task.description;
        return AlertDialog(
          title: Text('Editar Tarefa'),
          content: TextField(
            onChanged: (value) {
              editedTask = value;
            },
            controller: TextEditingController(text: task.description),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  task.description = editedTask;
                  _saveTasks();
                  _showFeedbackMessage('Tarefa editada com sucesso!');
                  Navigator.pop(context);
                });
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTask(int index) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Excluir Tarefa'),
          content: Text('Tem certeza de que deseja excluir esta tarefa?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _tasks.removeAt(index);
                  _saveTasks();
                  _showFeedbackMessage('Tarefa excluída com sucesso!');
                  Navigator.pop(context);
                });
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

 Future<void> _saveTasks() async {
    await _prefs.setStringList(
        'tasks${widget.user}', _tasks.map((task) => task.description).toList());
  }

  Future<void> _loadTasks() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = (_prefs.getStringList('tasks${widget.user}') ?? [])
          .map((task) => Task(description: task))
          .toList();
    });
  }
}

class Task {
  String description;
  bool completed;

  Task({required this.description, this.completed = false});
}
