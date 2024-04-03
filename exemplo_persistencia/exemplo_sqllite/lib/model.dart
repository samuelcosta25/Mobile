class ContatoModel {
  // O flutter não aceita variaveis nulas, portanto para determinar que a variavel vai receber um valor posteriormente, ou usaria: 'int ?id;' ou 'late int id'
  int id;
  String nome;
  String email;
  String telefone;
  String endereco;

  ContatoModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.endereco,
  });
  //mapeamento
}
