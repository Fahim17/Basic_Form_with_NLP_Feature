import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';

class PdfApi {
  // **********************************************************
  // **********************************************************
  static Future<File> savePDf(String name, String email, String phone) async {
    final pdf = Document();
    String txt = 'Name: $name \n Email: $email \n Phone: $phone';
    pdf.addPage(Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return Center(
          child: Text(txt, style: TextStyle(fontSize: 48)),
        );
      },
    ));

    return _saveDocument(name: 'example.pdf', pdf: pdf);
  }

  // **********************************************************
  // **********************************************************
  static Future<File> _saveDocument({
    String name,
    Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  // **********************************************************
  // **********************************************************
  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
