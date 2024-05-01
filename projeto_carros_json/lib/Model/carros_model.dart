class Carros {
  final String placa;
  final String modelo;
  final String marca;
  final int ano;
  final String cor;
  final String descricao;
  final double valor;
  final String imagem;

  Carros(
      {required this.placa,
      required this.modelo,
      required this.marca,
      required this.ano,
      required this.cor,
      required this.descricao,
      required this.valor,
      required this.imagem});

  Map<String, dynamic> toJson() {
    return {
      'placa': placa,
      'modelo': modelo,
      'marca': marca,
      'ano': ano,
      'cor': cor,
      'descricao': descricao,
      'valor': valor,
      'imagem': imagem,
    };
  }

  factory Carros.fromJson(Map<String, dynamic> map) {
    return Carros(
      placa: map['placa'],
      modelo: map['modelo'],
      marca: map['marca'],
      ano: map['ano'],
      cor: map['cor'],
      descricao: map['descricao'],
      valor: map['valor'],
      imagem: map['imagem'],
    );
  }
}
