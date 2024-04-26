class Produto {
  //Atributos
  int id;
  String nome;
  double preco;
  int quantidade;
  List<String> categoria;
  String foto;
  String descricao;

  //Construtor
  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.quantidade,
    required this.categoria,
    required this.foto,
    required this.descricao,
  });

  //Métodos (toJson e fromJson)
  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'preco': preco,
        'quantidade': quantidade,
        'categoria': categoria,
        'foto': foto,
        'descricao': descricao,
      };

  factory Produto.fromJson(Map<String, dynamic> json) => Produto(
        id: json['id'],
        nome: json['nome'],
        preco: json['preco'],
        quantidade: json['quantidade'],
        categoria: List<String>.from (json['categoria']),
        foto: json['foto'],
        descricao: json['descricao'],
      );
}
