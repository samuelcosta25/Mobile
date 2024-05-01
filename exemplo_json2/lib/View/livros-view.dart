import 'package:exemplo_json2/Controller/livros-controller.dart';
import 'package:exemplo_json2/View/info-livros-view.dart';
import 'package:flutter/material.dart';

class LivrosPage extends StatefulWidget {
  const LivrosPage({super.key});

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  LivrosController controller = new LivrosController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Livros"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Expanded(
            child: FutureBuilder(
                future: controller.loadLivros(),
                builder: (context, snapshot) {
                  if (controller.livros.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: controller.livros.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(controller.livros[index].titulo),
                            subtitle: Text(controller.livros[index].autor),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LivroInfoPage(
                                      info: controller.livros[index]),
                                )),
                          );
                        });
                  }
                })),
      ),
    );
  }
}
