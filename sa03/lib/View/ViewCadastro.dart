import 'package:flutter/material.dart';
import '/Controller/DataBaseController.dart';
import '/Model/UserModel.dart';

class CadastroView extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        backgroundColor: Color.fromARGB(255, 54, 74, 83),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navegar de volta para a tela anterior (login)
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Cadastro',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _nomeController,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          controller: _cpfController,
                          decoration: InputDecoration(
                            labelText: 'CPF',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          controller: _senhaController,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            _cadastrarUsuario(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_add),
                              SizedBox(width: 8.0),
                              Text('Cadastrar'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _cadastrarUsuario(BuildContext context) async {
    String nome = _nomeController.text;
    String cpf = _cpfController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;

    // Verifica se todos os campos estão preenchidos
    if (nome.isNotEmpty && cpf.isNotEmpty && email.isNotEmpty && senha.isNotEmpty) {
      // Verifica se o email já está cadastrado
      bool emailExiste = await _verificarEmailExiste(email);
      if (!emailExiste) {
        // Cria um novo usuário
        ContatoModel novoUsuario = ContatoModel(
          nome: nome,
          cpf: cpf,
          email: email,
          senha: senha,
        );

        // Chama a função de cadastro do banco de dados
        await BancoDadosCrud().create(novoUsuario);

        // Limpa os campos de entrada após o cadastro
        _nomeController.clear();
        _cpfController.clear();
        _emailController.clear();
        _senhaController.clear();

        // Mostra uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('USUÁRIO CADASTRADO COM SUCESSO')),
        );
      } else {
        // Mostra uma mensagem de erro se o email já está cadastrado
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('EMAIL JÁ CADASTRADO')),
        );
      }
    } else {
      // Mostra uma mensagem de erro se algum campo estiver vazio
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('POR FAVOR PREENCHER TODOS OS CAMPOS')),
      );
    }
  }

  // Função para verificar se o email já está cadastrado
  Future<bool> _verificarEmailExiste(String email) async {
    ContatoModel? usuario = await BancoDadosCrud().readByEmail(email);
    return usuario != null;
  }
}
