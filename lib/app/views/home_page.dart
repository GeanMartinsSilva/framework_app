import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework_app/app/models/model.dart';
import 'package:framework_app/app/views/carrinho_page.dart';
import 'package:framework_app/app/widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController controlQuantidade = TextEditingController();

  late List<ItemVenda> itensAVenda;
  String itemPesquisa = '';

  @override
  void initState() {
    super.initState();

    itensAVenda = itensVenda;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Framework Digital App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Carrinho()));
              });
            },
            icon: Icon(Icons.add_shopping_cart),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.shopping_cart),
        label: Text(
          'CARRINHO',
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          setState(() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Carrinho()));
          });
        },
      ),
      body: Column(
        children: <Widget>[
          buildSearch(),
          Expanded(
            child: ListView.builder(
              itemCount: itensAVenda.length,
              itemBuilder: (context, index) {
                final item = itensAVenda[index];
                return buildItem(item, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() {
    return SearchWidget(
      text: itemPesquisa,
      hintText: 'Qual fruta esta procurando?',
      onChanged: searchItem,
    );
  }

  Widget buildItem(ItemVenda item, int index) {
    return GestureDetector(
      onTap: () {
        verifica(item, item.fruta.toString(), index);
      },
      child: ListTile(
        title: Text(
          item.fruta,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: Text('R\$ ${item.precoUnit.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void searchItem(String itemPesquisa) {
    final itensAVenda = itensVenda.where((item) {
      final qualFruta = item.fruta.toLowerCase();
      final valorFruta = item.precoUnit.toString().toLowerCase();
      final buscador = itemPesquisa.toLowerCase();

      return qualFruta.contains(buscador) || valorFruta.contains(buscador);
    }).toList();

    setState(() {
      this.itemPesquisa = itemPesquisa;
      this.itensAVenda = itensAVenda;
    });
  }

  void verifica(ItemVenda item, String title, int index) {
    if (itensCarrinho.contains(item.fruta)) {
      dialogo(item, 'Você ja adicionou $title, verifique seu carrinho', true,
          index, 'Continuar compra');
    } else {
      dialogo(
          item, 'Quantas quer levar?', false, index, 'Adicionar ao carrinho');
    }
  }

  void dialogo(
      ItemVenda item, String texto, bool teste, int index, String botao) {
    controlQuantidade.text = '1';
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Column(
            children: [
              Text(
                texto,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
              teste
                  ? Container()
                  : TextField(
                      textAlign: TextAlign.center,
                      controller: controlQuantidade,
                      style: TextStyle(fontSize: 24.0),
                      keyboardType: TextInputType.number,
                    ),
            ],
          )),
          actions: <Widget>[
            RaisedButton(
              color: Color(0xff7900DF),
              child: Center(
                  child: Text(
                botao,
                style: TextStyle(color: Colors.white),
              )),
              onPressed: () {
                int? quant = int.tryParse(controlQuantidade.text);
                verificaCompra(item, index, quant!);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void verificaCompra(ItemVenda item, int index, int quant) {
    final double unit = item.precoUnit;
    if (itensCarrinho.contains(item.fruta)) {
      print('Já está no carrinho');
    } else {
      double valorTotal = quant * item.precoUnit;
      addItem(item, quant, unit, valorTotal);
    }
  }

  void addItem(ItemVenda item, int quant, double unit, double ix) {
    itensCarrinho.add(item.fruta);
    setState(() {
      transferencias.add(ItemCarrinho(item.fruta, quant, unit, ix));
    });
  }
}
