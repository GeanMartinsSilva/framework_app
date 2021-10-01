import 'dart:io';

import 'package:framework_app/app/models/model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generateCenteredText(String text) async {
    final pdf = Document();

    pdf.addPage(
      Page(
        build: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Recibo de venda do Framework E-Commerce',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              for (int i = 0; i < transferencias.length; i++)
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        transferencias[i].quantidade.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        transferencias[i].nomeFruta,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: 100),
                      Text(
                        'R\$ ${transferencias[i].totalItem.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  'Total R\$ $text',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ]),
              SizedBox(height: 50),
              Text(
                'O total do seu pedido ficou em ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(),
              Text(
                'R\$ $text',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              Text(
                'Volte Sempre',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );

    return saveDocument(name: 'Recibo Framework App.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static List<Widget> buildBulletPoints() => [
        Bullet(text: 'First Bullet'),
        Bullet(text: 'Second Bullet'),
        Bullet(text: 'Third Bullet'),
      ];
}
