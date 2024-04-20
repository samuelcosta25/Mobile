import 'package:flutter/material.dart';
import '/Controller/DataBaseController.dart';
import '/View/ViewHomePage.dart';
import 'ViewCadastro.dart'; // Importa o modelo de usuário

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Login'),
        backgroundColor: Color.fromARGB(255, 95, 0, 0),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'POR FAVOR, DIGITE O USUÁRIO';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'POR FAVOR, DIGITE A SENHA';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Validar os campos do formulário
        
                  String email = _usernameController.text;
                  String senha = _passwordController.text;
        
                  // Verificar se o usuário com o e-mail fornecido está cadastrado
                  if (await BancoDadosCrud()
                      .checkUserByEmailExists(email, senha)) {
                    print('Sucesso!');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaskListScreen(user:email)),
                    ); 
                  } else {
                    // Usuário não encontrado
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Erro de login'),
                          content: Text('USUÁRIO NÃO CADASTRADO'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                // Navega para a tela de cadastro ao pressionar o botão "Cadastre-se"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CadastroView()), // Navega para a tela de cadastro
                );
              },
              child: Text('Não possui Login? Cadastre-se!'),
            ),
          ],
        ),
      ),
    );
  }
}
