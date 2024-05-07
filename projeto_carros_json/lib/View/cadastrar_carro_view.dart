import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Controller/carros_controller.dart';
import '../Model/carros_model.dart';

class CarroCadastroScreen extends StatefulWidget {
  const CarroCadastroScreen({super.key});

  @override
  State<CarroCadastroScreen> createState() => _CarroCadastroScreenState();
}

class _CarroCadastroScreenState extends State<CarroCadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _placaController = TextEditingController();
  TextEditingController _modeloController = TextEditingController();
  TextEditingController _marcaController = TextEditingController();
  TextEditingController _anoController = TextEditingController();
  TextEditingController _corController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _valorController = TextEditingController();

  File? _imagemSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Carro"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _placaController,
                    decoration: const InputDecoration(labelText: 'Placa'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Placa Não Pode Ser Vazia!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _modeloController,
                    decoration: const InputDecoration(labelText: 'Modelo'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Modelo Não Pode Ser Vazio!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _marcaController,
                    decoration: const InputDecoration(labelText: 'Marca'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Marca Não Pode Ser Vazia!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _anoController,
                    decoration: const InputDecoration(labelText: 'Ano'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Ano Não Pode Ser Vazio!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _corController,
                    decoration: const InputDecoration(labelText: 'Cor'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Cor Não Pode Ser Vazia!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _descricaoController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Descrição Não Pode Ser Vazia!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _valorController,
                    decoration: const InputDecoration(labelText: 'Valor'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Valor Não Pode Ser Vazio!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _imagemSelecionada != null
                      ? Image.file(
                          _imagemSelecionada!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : SizedBox.shrink(),
                  ElevatedButton(
                    onPressed: _tirarFoto,
                    child: Text('Tirar Foto'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _cadastrarCarro();
                      }
                    },
                    child: Text("Cadastrar"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
      });
    }
  }

  Carros criarObjeto() {
    return Carros(
        placa: _placaController.text,
        modelo: _modeloController.text,
        marca: _marcaController.text,
        ano: int.parse(_anoController.text),
        cor: _corController.text,
        descricao: _descricaoController.text,
        imagem: _imagemSelecionada!.path,
        valor: double.parse(_valorController.text));
  }

  CarrosController _controller = new CarrosController();

  void _limparCampos() {
    _placaController.clear();
    _modeloController.clear();
    _marcaController.clear();
    _anoController.clear();
    _corController.clear();
    _descricaoController.clear();
    _valorController.clear();
    _imagemSelecionada = null;
  }

  void _apagarCampos() {
    _placaController.text = "";
    _modeloController.text = "";
    _marcaController.text = "";
    _anoController.text = "";
    _corController.text = "";
    _descricaoController.text = "";
    _valorController.text = "";
    _imagemSelecionada = null;
    setState((){});
  }

  void _cadastrarCarro() {
    //cadastrar
    _controller.addCarro(criarObjeto());

    //Limpar os valores armazenados dos campos
    _limparCampos();

    //Apagar o texto na caixa de escrito dos campos
    _apagarCampos();
  }
}
