class ItemCarrinho {
  String nomeFruta;
  int quantidade;
  double unit;
  double totalItem;

  ItemCarrinho(this.nomeFruta, this.quantidade, this.unit, this.totalItem);

  @override
  String toString() {
    return 'ItemCarrinho{item: $nomeFruta, quantidade: $quantidade, valor unit $unit, valor total $totalItem}';
  }
}

final List<ItemCarrinho> transferencias = [];
final List itensCarrinho = [];

class ItemVenda {
  final String fruta;
  final double precoUnit;

  ItemVenda(this.fruta, this.precoUnit);
}

final itensVenda = <ItemVenda>[
  ItemVenda('Abacaxi', 5),
  ItemVenda('Maça', 1),
  ItemVenda('Pera', 2),
  ItemVenda('Banana', 4),
  ItemVenda('Manga', 3),
];
