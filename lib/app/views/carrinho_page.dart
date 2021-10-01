import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework_app/app/api/pdf_api.dart';
import 'package:framework_app/app/models/model.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({Key? key}) : super(key: key);

  @override
  _Carrinho createState() => _Carrinho();
}

class _Carrinho extends State<Carrinho> {
  TextEditingController editQuantidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double valorCompra = 0;
    final double valorTotal = transferencias.fold<double>(
        valorCompra, (previus, value) => previus + value.totalItem);

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.picture_as_pdf),
        label: Text(
          'GERAR RECIBO',
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () async {
          final pdfFile =
              await PdfApi.generateCenteredText(valorTotal.toStringAsFixed(2));
          PdfApi.openFile(pdfFile);
        },
      ),
      body: Column(
        children: [
          Container(),
          Expanded(
            child: ListView.builder(
              itemCount: transferencias.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    apagar(index);
                  },
                  child: GestureDetector(
                    onTap: () {
                      editQuantidade.text =
                          transferencias[index].quantidade.toString();
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Gostaria de alterar a quantidade de',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(transferencias[index].nomeFruta),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: editQuantidade,
                                          style: TextStyle(fontSize: 24.0),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              Navigator.of(context).pop();
                                              transferencias[index].quantidade =
                                                  int.tryParse(
                                                      editQuantidade.text)!;
                                              transferencias[index].totalItem =
                                                  transferencias[index]
                                                          .quantidade *
                                                      transferencias[index]
                                                          .unit;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.check,
                                            size: 40,
                                          )),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RaisedButton(
                                          color: Color(0xff7900DF),
                                          onPressed: () {
                                            print(transferencias);
                                            apagar(index);
                                            Navigator.of(context).pop();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.dangerous_outlined,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text('Remover item',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            transferencias[index].nomeFruta,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Quantidade: ${transferencias[index].quantidade.toString()}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            'R\$ ${transferencias[index].totalItem.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
              child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                Text(
                  'Sua compra está dando R\$ ${valorTotal.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  void apagar(int index) {
    var item = transferencias[index].nomeFruta.toString();
    setState(
      () {
        if (itensCarrinho.contains(item)) {
          itensCarrinho.remove(item);
        }
        print(itensCarrinho);
        transferencias.removeAt(index);
      },
    );
  }
}
